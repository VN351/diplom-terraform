
resource "yandex_vpc_security_group" "k8s_sg" {
  name        = "k8s-vm-sg"
  description = "Security group for Kubernetes VMs"

  network_id = yandex_vpc_network.network-nvv.id
  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает доступ к VM по порту 22"
    v4_cidr_blocks = ["89.169.9.137/32", "77.37.212.183/32", "89.23.105.168/32"]
    port           = 22
  }
  ingress {
    protocol          = "TCP"
    description       = "Правило разрешает проверки доступности с диапазона адресов балансировщика нагрузки"
    predefined_target = "loadbalancer_healthchecks"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol          = "ANY"
    description       = "Правило разрешает взаимодействие мастер-узел и узел-узел внутри группы безопасности"
    predefined_target = "self_security_group"
    from_port         = 0
    to_port           = 65535
  }
  ingress {
    protocol       = "ANY"
    description    = "Правило разрешает взаимодействие под-под и сервис-сервис"
    v4_cidr_blocks = flatten(values(yandex_vpc_subnet.subnets-dip)[*].v4_cidr_blocks)
    from_port      = 0
    to_port        = 65535
  }
  ingress {
    protocol       = "ICMP"
    description    = "Правило разрешает отладочные ICMP-пакеты из внутренних подсетей"
    v4_cidr_blocks = ["10.10.10.0/24", "10.10.40.0/24", "10.10.50.0/24"]
  }
  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает доступ к Kubernetes API по порту 6443"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 6443
  }
  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает доступ к Kubernetes API по порту 443"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 443
  }
  ingress {
    protocol       = "TCP"
    description    = "Правило разрешает доступ к Kubernetes API по порту 80"
    v4_cidr_blocks = ["0.0.0.0/0"]
    port           = 80
  }
  egress {
    protocol       = "ANY"
    description    = "Правило разрешает весь исходящий трафик"
    v4_cidr_blocks = ["0.0.0.0/0"]
    from_port      = 0
    to_port        = 65535
  }
}
