data "aws_ami" "ubuntu" {
  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-arm64-server-*"]
  }
}

resource "aws_instance" "classroom_ec2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t4g.small"
  subnet_id                   = aws_subnet.public_subnet.id
  vpc_security_group_ids      = [aws_security_group.classroom_sg.id]
  key_name                    = aws_key_pair.classroom_key.key_name
  associate_public_ip_address = true

  tags = {
    Name = "Classroom-Booking-EC2"
  }
}
