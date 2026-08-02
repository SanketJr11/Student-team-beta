resource "hcloud_firewall" "classroom_firewall" {
  name = "classroom-booking-firewall"

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "22"
    source_ips  = [var.admin_ip_cidr]
    description = "SSH access"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "32084"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "Auth Service NodePort"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "32081"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "Room Service NodePort"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "32083"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "Booking Service NodePort"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "32090"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "Prometheus NodePort"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "80"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "HTTP for K3s Traefik"
  }

  rule {
    direction   = "in"
    protocol    = "tcp"
    port        = "443"
    source_ips  = ["0.0.0.0/0", "::/0"]
    description = "HTTPS for K3s Traefik"
  }

  rule {
    direction = "out"
    protocol  = "tcp"
    port      = "any"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
    description = "Allow outbound TCP traffic"
  }

  rule {
    direction = "out"
    protocol  = "udp"
    port      = "any"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
    description = "Allow outbound UDP traffic"
  }

  rule {
    direction = "out"
    protocol  = "icmp"
    destination_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
    description = "Allow outbound ICMP"
  }
}