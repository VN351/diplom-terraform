/*
resource "yandex_iam_service_account" "vlad_sa" {
  name        = "vlad-sa"
  description = "For diplom"
  folder_id   = var.yc_folder_id
}

resource "yandex_resourcemanager_folder_iam_member" "roles" {
  for_each = toset(local.roles)
  folder_id = var.yc_folder_id
  role      = each.key
  member    = "serviceAccount:${yandex_iam_service_account.vlad_sa.id}"
}
*/