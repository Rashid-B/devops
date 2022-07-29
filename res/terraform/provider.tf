# Provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
      version = "0.75.0"
    }
  }
    backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = ""
    region     = "ru-central1"
    key        = "terraform.tfstate"
    access_key = ""
    secret_key = ""
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}


provider "yandex" {
  token     = "${var.yandex_token}"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
}
