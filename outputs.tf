output "registry" {
  value = yandex_container_registry.app.id
}

output "nlb_external_ip" {
  description = "External IP of the NLB"
  value       = yandex_lb_network_load_balancer.k8s_nlb.listener[0].external_address_spec[0].address
}