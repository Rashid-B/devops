resource "yandex_compute_instance" "app" {
  name                      = "app"
  zone                      = var.zones[2]
  hostname                  = "app.weget2u.ru"
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
    core_fraction = 20
  }

    boot_disk {
        initialize_params {
          image_id = data.yandex_compute_image.ubuntu_image.id
        }
      }

    network_interface {
      subnet_id = "${yandex_vpc_subnet.default[2].id}"
      ip_address  = "192.168.102.100"
      nat       = false

    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    }

    resource "yandex_dns_recordset" "rsapp" {
      zone_id = yandex_dns_zone.zone1.id
      name    = "app.weget2u.ru."
      type    = "A"
      ttl     = 200
      data    = ["${yandex_compute_instance.app.network_interface.0.ip_address}"]
    }
