resource "aws_vpc" "cluster-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_subnet" "cluster-subnet" {
  cidr_block = "10.0.80.0/20"
  vpc_id     = aws_vpc.cluster-vpc.id
}

resource "aws_security_group" "k8s-sg" {
  name   = "k8s-sg"
  vpc_id = aws_vpc.cluster-vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.cluster-vpc.id
}

resource "aws_route_table" "route-table" {
  vpc_id = aws_vpc.cluster-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet-gw.id
  }
}

resource "aws_route_table_association" "subnet-association" {
  subnet_id      = aws_subnet.cluster-subnet.id
  route_table_id = aws_route_table.route-table.id
}

resource "aws_network_interface" "network-manager" {
  subnet_id       = aws_subnet.cluster-subnet.id
  private_ips     = ["10.0.80.40"]
  security_groups = [aws_security_group.k8s-sg.id]

  tags = {
    Name = "Primary manager node interface"
  }
}

resource "aws_network_interface" "network-worker01" {
  subnet_id       = aws_subnet.cluster-subnet.id
  private_ips     = ["10.0.80.43"]
  security_groups = [aws_security_group.k8s-sg.id]

  tags = {
    Name = "Primary worker01 node interface"
  }
}

resource "aws_network_interface" "network-worker02" {
  subnet_id       = aws_subnet.cluster-subnet.id
  private_ips     = ["10.0.80.44"]
  security_groups = [aws_security_group.k8s-sg.id]

  tags = {
    Name = "Primary worker02 node interface"
  }
}
