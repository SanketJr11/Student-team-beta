resource "hcloud_ssh_key" "classroom_key" {
  name       = "classroom-booking-key"
  public_key = file(pathexpand(var.ssh_public_key_path))
}