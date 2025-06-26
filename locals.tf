
locals {
  roles = [
    "storage.admin",
    "editor"
  ]

  subnets = [
    { name = "subnet-1", cidr = "10.10.10.0/24", zone = "ru-central1-a" },
    { name = "subnet-2", cidr = "10.10.40.0/24", zone = "ru-central1-b" },
    { name = "subnet-3", cidr = "10.10.50.0/24", zone = "ru-central1-d" }
  ]
  
  instances = [
    { name = "k8s-master", zone = "ru-central1-a", subnet = "subnet-1", cores = 2, memory = 4, core_fraction = 20, size = 15 },
    { name = "k8s-worker-1", zone = "ru-central1-b", subnet = "subnet-2", cores = 2, core_fraction = 20, memory = 6,size = 15 },
    { name = "k8s-worker-2", zone = "ru-central1-d", subnet = "subnet-3", cores = 2, core_fraction = 20, memory = 6,size = 15 }
  ]
  
  metadata = {
        "serial-port-enable" = "1"
        "ssh-keys"           = "${var.ssh_username}:${var.vms_ssh_root_key}"
    }
  
  k8s_nodes_ip = [for vm in values(yandex_compute_instance.instances) : vm.network_interface[0].nat_ip_address]

}
