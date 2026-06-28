resource "aws_internet_gateway" "classroom_igw" {
  vpc_id = aws_vpc.classroom_vpc.id

  tags = {
    Name = "Classroom-Internet-Gateway"
  }
}