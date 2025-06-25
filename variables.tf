variable "yc_token" {
  description = "Yandex Cloud OAuth token"
  type        = string
}

variable "yc_cloud_id" {
  description = "Yandex Cloud ID"
  type        = string
}

variable "yc_folder_id" {
  description = "Yandex Cloud Folder ID"
  type        = string
}

variable "yc_dns_zone_id" {
  description = "Yandex Cloud DNS zone ID"
  type        = string
}

variable "yc_zone" {
  description = "Yandex Cloud zone"
  type        = string
  default     = "ru-central1-a"
}

variable "nat" {
  description = "Включение NAT"
  type = map(string)
  default = {
    "yes" = "true"
    "no"  = "false"
  }
}

variable "vm_os_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "OS family"  
}

variable "vms_ssh_root_key" {
  description = "Путь к публичному SSH ключу"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC8bDGbiyUNa2k07/T9jlaRKD1gMcMT9/4wqljOvFJOD nevzorovvlad@mail.ru"
}

variable "ssh_username" {
  description = "Имя пользователя для SSH ключей"
  type        = string
  default     = "vlad"
}

variable "platform_id" {
  description = "Выбор платформы"
  type = map(string)
  default = {
    "pi1" = "standard-v1"
    "pi2" = "standard-v2"
    "pi3" = "standard-v3"
  }   
 }

variable "disk_type" {
  description = "Выбор диска"
  type = map(string)
  default = {
    "disk1" = "network-hdd"
    "disk2" = "network-ssd"
    "disk3" = "network-ssd-nonreplicated"
    "disk4" = "network-ssd-io"
  }   
 }