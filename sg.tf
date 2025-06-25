resource "yandex_vpc_security_group" "k8s_sg" {
  name        = "k8s-vm-sg"
  description = "Security group for Kubernetes VMs"

  network_id = yandex_vpc_network.network-nvv.id

  # Входящие правила
  ingress {
    protocol       = "TCP"
    description    = "SSH from anywhere"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Kubernetes API from anywhere"
    port           = 6443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP within SG"
    port           = 80
    predefined_target = "self_security_group"
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow HTTP within SG"
    port           = 443
    predefined_target = "self_security_group"
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow etcd within SG"
    port             = 2379
    predefined_target = "self_security_group"
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow etcd within SG"
    port             = 2380
    predefined_target = "self_security_group"
  }

  ingress {
    protocol       = "TCP"
    description    = "Allow Kubelet metrics within SG"
    port           = 10250
    predefined_target = "self_security_group"
  }
  
  ingress {
    protocol       = "TCP"
    description    = "Allow Kubelet read-only within SG"
    port           = 10255
    predefined_target = "self_security_group"
  }

  ingress {
    description = "Health checks from NLB"
    protocol = "TCP"
    predefined_target = "loadbalancer_healthchecks"
  }
  # Исходящие правила (по умолчанию можно оставить открытыми)
  egress {
    protocol       = "ANY"
    description    = "Allow all outbound traffic"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
