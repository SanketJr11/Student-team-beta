output "vpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.classroom_vpc.id
}

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.classroom_ec2.public_ip
}