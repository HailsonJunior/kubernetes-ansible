resource "aws_spot_instance_request" "manager" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  user_data     = file("init-script.sh")
  key_name      = aws_key_pair.my-key.key_name

  network_interface {
    network_interface_id = aws_network_interface.network-manager.id
    device_index         = 0
  }

  root_block_device {
    volume_size = var.aws_root_ebs_size
  }

  tags = {
    Name = "k8s-manager01"
  }
}

resource "aws_spot_instance_request" "worker01" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  user_data     = file("init-script.sh")
  key_name      = aws_key_pair.my-key.key_name

  network_interface {
    network_interface_id = aws_network_interface.network-manager.id
    device_index         = 0
  }

  root_block_device {
    volume_size           = var.aws_root_ebs_size
    volume_type           = var.aws_root_ebs_type
    delete_on_termination = true
  }

  tags = {
    Name = "k8s-worker01"
  }
}

resource "aws_spot_instance_request" "worker02" {
  ami           = var.aws_ami
  instance_type = var.aws_instance_type
  user_data     = file("init-script.sh")
  key_name      = aws_key_pair.my-key.key_name

  network_interface {
    network_interface_id = aws_network_interface.network-manager.id
    device_index         = 0
  }

  root_block_device {
    volume_size = var.aws_root_ebs_size
  }

  tags = {
    Name = "k8s-worker02"
  }
}

resource "aws_key_pair" "my-key" {
  key_name   = "my-key"
  public_key = file("~/.ssh/id_rsa.pub")
}
