
resource "yandex_vpc_network" "network-nvv" {
  name = "network-nv"
}

resource "yandex_vpc_subnet" "subnets-dip" {
  for_each       = { for idx, subnet in local.subnets : subnet.name => subnet }
  name           = each.value.name
  v4_cidr_blocks = [each.value.cidr]
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network-nvv.id
}



