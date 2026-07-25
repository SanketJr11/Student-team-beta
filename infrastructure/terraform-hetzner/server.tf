resource "hcloud_server" "classroom_server" {
  name        = var.server_name
  server_type = var.server_type
  image       = var.image
  location    = var.location

  ssh_keys = [
    hcloud_ssh_key.classroom_key.id
  ]

  firewall_ids = [
    hcloud_firewall.classroom_firewall.id
  ]

  public_net {
    ipv4_enabled = true
    ipv6_enabled = true
  }

  labels = {
    project     = "classroom-booking"
    environment = "development"
    platform    = "k3s"
    cloud       = "hetzner"
  }

  lifecycle {
    prevent_destroy = true
  }
}