# Connection

resource "aws_vpc" "jenkins_vpc" {
  cidr_block = "192.168.0.0/16"
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id     = aws_vpc.jenkins_vpc.id
  cidr_block = "192.168.10.0/24"
}

resource "aws_vpn_gateway" "jenkins_vpn_gw" {
  vpc_id = aws_vpc.jenkins_vpc.id
}

resource "aws_security_group" "jenkins_asg" {

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.10.0/24"]
  }

   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route_table" "jenkins_route" {
  vpc_id = aws_vpc.jenkins_vpc.id

  route {
    cidr_block = "192.168.0.10/24"
    gateway_id = aws_vpn_gateway.jenkins_vpn_gw.id
  }
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.jenkins_route.id
}

# Instance

resource "aws_instance" "jenkins_instance" {
  ami               = "ami-04716897be83e3f04"
  instance_type     = "t2.micro"
  availability_zone = var.aws_region
  subnet_id         = aws_subnet.jenkins_subnet.id
}