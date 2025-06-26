/*
resource "yandex_lb_target_group" "k8s_nlb_tg" {
  name      = "k8s-nlb-tg"
  region_id = "ru-central1"

  dynamic "target" {
    for_each = yandex_compute_instance.instances
    content {
      subnet_id = target.value.network_interface[0].subnet_id
      address   = target.value.network_interface[0].ip_address
    }
  }
}

resource "yandex_lb_network_load_balancer" "k8s_nlb" {
  name = "k8s-nlb"
  type = "external"

  listener {
    name        = "http"
    port        = 80
    target_port = 31088
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.k8s_nlb_tg.id

    healthcheck {
      name = "tcp"
      tcp_options {
        port = 31088
      }
    }
  }
}
*/