
resource "yandex_compute_instance" "instances" {
  for_each    = { for idx, instance in local.instances : instance.name => instance }
  name        = each.value.name
  platform_id = var.platform_id.pi3
  zone        = each.value.zone
  service_account_id = yandex_iam_service_account.vlad_sa.id

  resources {
    cores  = each.value.cores
    memory = each.value.memory
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = var.disk_type.disk1
      size     = each.value.size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnets-dip[each.value.subnet].id
    nat       = var.nat.yes
  }

  metadata = local.metadata

  allow_stopping_for_update = true
}

data "yandex_compute_image" "ubuntu" {
    family = "${var.vm_os_family}"
}


