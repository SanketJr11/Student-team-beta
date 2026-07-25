variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "server_name" {
  description = "Hetzner server name"
  type        = string
  default     = "classroom-booking-k3s"
}

variable "server_type" {
  description = "Hetzner Cloud server type"
  type        = string
  default     = "cx23"
}

variable "location" {
  description = "Hetzner Cloud location"
  type        = string
  default     = "nbg1"
}

variable "image" {
  description = "Operating system image"
  type        = string
  default     = "ubuntu-22.04"
}

variable "ssh_public_key_path" {
  description = "Path to SSH public key"
  type        = string
  default     = "~/.ssh/classroom-key.pub"
}

variable "admin_ip_cidr" {
  description = "CIDR allowed to access SSH"
  type        = string
  default     = "0.0.0.0/0"
}