resource "aws_security_group" "k8s-sg" {
    name = "k8s-sg"
    ingress {
        from_port = 0
        to_port =0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_network_interface" "network-manager1" {
    subnet_id = var.subnet_id
    private_ips = ["172.31.87.40"]
    security_groups = [aws_security_group.k8s-sg.id]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_network_interface" "network-manager2" {
    subnet_id = var.subnet_id
    private_ips = ["172.31.87.41"]
    security_groups = [aws_security_group.k8s-sg.id]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_network_interface" "network-manager3" {
    subnet_id = var.subnet_id
    private_ips = ["172.31.87.42"]
    security_groups = [aws_security_group.k8s-sg.id]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_network_interface" "network-worker1" {
    subnet_id = var.subnet_id
    private_ips = ["172.31.87.43"]
    security_groups = [aws_security_group.k8s-sg.id]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_network_interface" "network-worker2" {
    subnet_id = var.subnet_id
    private_ips = ["172.31.87.44"]
    security_groups = [aws_security_group.k8s-sg.id]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_network_interface" "network-worker3" {
    subnet_id = var.subnet_id
    private_ips = ["172.31.87.45"]
    security_groups = [aws_security_group.k8s-sg.id]

    tags = {
        Name = "primary_network_interface"
    }
}

resource "aws_network_interface" "network-haproxy" {
    subnet_id = var.subnet_id
    private_ips = ["172.31.87.46"]
    security_groups = [aws_security_group.k8s-sg.id]

    tags = {
        Name = "primary_network_interface"
    }
}
