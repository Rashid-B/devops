# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_cloud_id" {
  default = "b1ghcgeonpfeea6hu2ug"
}


# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1gsdhs7feprbdva4ftl"
}


variable "yandex_token" {
  default = "*******************"
}

variable "zones" {
  type    = list(string)
}

variable "cidr" {
  type    = list(string)
}

