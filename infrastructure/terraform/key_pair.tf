resource "aws_key_pair" "classroom_key" {
  key_name   = "classroom-key"
  public_key = file("~/.ssh/classroom-key.pub")
}