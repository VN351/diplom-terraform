
resource "yandex_vpc_security_group" "k8s_sg" {
  name        = "k8s-vm-sg"
  description = "Security group for Kubernetes VMs"

  network_id = yandex_vpc_network.network-nvv.id

  # SSH только с доверенных IP
  ingress {
    protocol       = "TCP"
    description    = "SSH access"
    v4_cidr_blocks = ["89.169.9.137/32", "77.37.212.183/32", "89.23.105.168/32"]
    port           = 22
  }

  # Проверки доступности от балансировщика
  ingress {
    protocol          = "TCP"
    description       = "Load balancer healthchecks"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }

  # Взаимодействие мастер-узел и узел-узел внутри группы безопасности
  ingress {
    protocol          = "ANY"
    description       = "Node to node communication"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }

  # Взаимодействие под-под и сервис-сервис внутри кластера
  ingress {
    protocol       = "ANY"
    description    = "Pod-to-pod and service-to-service"
    v4_cidr_blocks = flatten(values(yandex_vpc_subnet.subnets-dip)[*].v4_cidr_blocks)
    from_port      = 0
    to_port        = 65535
  }

  # ICMP для отладки из внутренних подсетей
  ingress {
    protocol       = "ICMP"
    description    = "ICMP from internal subnets"
    v4_cidr_blocks = ["10.10.10.0/24", "10.10.40.0/24", "10.10.50.0/24"]
  }

  # Kubernetes API только с доверенных IP (или VPN)
  ingress {
    protocol       = "TCP"
    description    = "Kubernetes API (6443) only from trusted IPs"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }

  # HTTP/HTTPS только с балансировщика
  ingress {
    protocol       = "TCP"
    description    = "HTTP from anywhere (not secure!)"
    v4_cidr_blocks = ["10.10.10.0/24", "10.10.40.0/24", "10.10.50.0/24"]
    port           = 80
  }
  ingress {
    protocol       = "TCP"
    description    = "HTTPS from anywhere (not secure!)"
    v4_cidr_blocks = ["10.10.10.0/24", "10.10.40.0/24", "10.10.50.0/24"]
    port           = 443
  }

  # Исходящий трафик весь разрешён (или ограничьте по необходимости)
  egress {
    protocol       = "ANY"
    description    = "All outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
