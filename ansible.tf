resource "local_file" "kubespray_inventory" {
  filename = "/home/vlad/diplom-test-2/03-ansible/inventory/inventory.ini"
  content  = local.kubespray_inventory
}
