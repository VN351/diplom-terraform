
resource "yandex_container_registry" "app" {
  name      = "app-registry"
  folder_id = var.yc_folder_id

  labels = {
    my-label = "app-registry"
  }
}
