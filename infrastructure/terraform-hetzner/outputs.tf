output "server_id" {
  description = "Hetzner server ID"
  value       = hcloud_server.classroom_server.id
}

output "server_name" {
  description = "Hetzner server name"
  value       = hcloud_server.classroom_server.name
}

output "server_ipv4" {
  description = "Hetzner public IPv4 address"
  value       = hcloud_server.classroom_server.ipv4_address
}

output "server_ipv6" {
  description = "Hetzner public IPv6 address"
  value       = hcloud_server.classroom_server.ipv6_address
}

output "ssh_command" {
  description = "Command to connect to the Hetzner server"
  value       = "ssh -i ~/.ssh/classroom-key root@${hcloud_server.classroom_server.ipv4_address}"
}

output "auth_service_url" {
  value = "http://${hcloud_server.classroom_server.ipv4_address}:32084"
}

output "room_service_url" {
  value = "http://${hcloud_server.classroom_server.ipv4_address}:32081"
}

output "booking_service_url" {
  value = "http://${hcloud_server.classroom_server.ipv4_address}:32083"
}