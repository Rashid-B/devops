
resource "yandex_dns_zone" "zone1" {
  name        = "weget2u-public-zone"
  description = "weget2u public zone"

  labels = {
    label1 = "weget2u-public"
  }

  zone    = "weget2u.ru."
  public  = true
}


resource "yandex_dns_recordset" "rs1" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "weget2u.ru."
  type    = "A"
  ttl     = 200
  data    = [" ${yandex_compute_instance.nginx.network_interface.0.nat_ip_address} "]
}

resource "yandex_dns_recordset" "rs2" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "www.weget2u.ru."
  type    = "A"
  ttl     = 200
  data    = [" ${yandex_compute_instance.nginx.network_interface.0.nat_ip_address} "]
}


resource "yandex_dns_recordset" "rs3" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "gitlab.weget2u.ru."
  type    = "A"
  ttl     = 200
  data    = [" ${yandex_compute_instance.nginx.network_interface.0.nat_ip_address} "]
}

resource "yandex_dns_recordset" "rs4" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "grafana.weget2u.ru."
  type    = "A"
  ttl     = 200
  data    = [" ${yandex_compute_instance.nginx.network_interface.0.nat_ip_address} "]
}

resource "yandex_dns_recordset" "rs5" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "prometheus.weget2u.ru."
  type    = "A"
  ttl     = 200
  data    = [" ${yandex_compute_instance.nginx.network_interface.0.nat_ip_address} "]
}

resource "yandex_dns_recordset" "rs6" {
  zone_id = yandex_dns_zone.zone1.id
  name    = "alertmanager.weget2u.ru."
  type    = "A"
  ttl     = 200
  data    = [" ${yandex_compute_instance.nginx.network_interface.0.nat_ip_address} "]
}
