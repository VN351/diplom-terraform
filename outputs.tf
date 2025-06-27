output "registry" {
  value = yandex_container_registry.app.id
}

output "internal_ips" {
  description = "Внутренние IP-адреса инстансов"
  value = {
    for name, instance in yandex_compute_instance.instances :
    name => instance.network_interface[0].ip_address
  }
}

output "external_ips" {
  description = "Внешние IP-адреса инстансов"
  value = {
    for name, instance in yandex_compute_instance.instances :
    name => instance.network_interface[0].nat_ip_address
  }
}