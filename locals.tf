locals {
  
  instances = [
    { name = "k8s-master", zone = "ru-central1-a", subnet = "subnet-1", cores = 2, memory = 4,size = 15 },
    { name = "k8s-worker-1", zone = "ru-central1-b", subnet = "subnet-2", cores = 2, memory = 6,size = 15 },
    { name = "k8s-worker-2", zone = "ru-central1-b", subnet = "subnet-3", cores = 2, memory = 6,size = 15 }
  ]
  
  metadata = {
        "serial-port-enable" = "1"
        "ssh-keys"           = "${var.ssh_username}:${file(var.vms_ssh_root_key)}"
    }
  
  k8s_nodes_ip = [for vm in values(yandex_compute_instance.instances) : vm.network_interface[0].nat_ip_address]
  
  subnets = [
    { name = "subnet-1", cidr = "10.10.10.0/24", zone = "ru-central1-a" },
    { name = "subnet-2", cidr = "10.10.40.0/24", zone = "ru-central1-b" },
    { name = "subnet-3", cidr = "10.10.50.0/24", zone = "ru-central1-b" }
  ]

  kubespray_inventory = <<EOT
    [kube_control_plane]
    %{ for name, instance in yandex_compute_instance.instances }
    %{ if name == "k8s-master" }
    node-${name} ansible_host=${instance.network_interface[0].nat_ip_address} ip=${instance.network_interface[0].ip_address} access_ip=${instance.network_interface[0].nat_ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=/home/vlad/.ssh/id_ed25519 etcd_member_name=etcd1
    %{ endif }
    %{ endfor }

    [etcd]
    %{ for name, instance in yandex_compute_instance.instances }
    %{ if name == "k8s-master" }
    node-${name} ansible_host=${instance.network_interface[0].nat_ip_address} ip=${instance.network_interface[0].ip_address} access_ip=${instance.network_interface[0].nat_ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=/home/vlad/.ssh/id_ed25519
    %{ endif }
    %{ endfor }

    [kube_node]
    %{ for name, instance in yandex_compute_instance.instances }
    %{ if name != "k8s-master" }
    node-${name} ansible_host=${instance.network_interface[0].nat_ip_address} ip=${instance.network_interface[0].ip_address} access_ip=${instance.network_interface[0].nat_ip_address} ansible_user=ubuntu ansible_ssh_private_key_file=/home/vlad/.ssh/id_ed25519
    %{ endif }
    %{ endfor }

    [k8s_cluster:children]
    kube_control_plane
    kube_node
    etcd
  EOT
}
