resource "aws_instance" "manager1" {
    instance_type = var.k8s_type
    ami = var.ami 
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = "${aws_network_interface.network-manager1.id}"
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_k8s
        volume_type = var.block_type_k8s
        delete_on_termination = true
    }

    tags = {
        Name = "K8s - Manager 1"
    }
}

resource "aws_instance" "manager2" {
    instance_type = var.k8s_type
    ami = var.ami 
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = "${aws_network_interface.network-manager2.id}"
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_k8s
        volume_type = var.block_type_k8s
        delete_on_termination = true
    }

    tags = {
        Name = "K8s - Manager 2"
    }
}

resource "aws_instance" "manager3" {
    instance_type = var.k8s_type
    ami = var.ami 
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = "${aws_network_interface.network-manager3.id}"
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_k8s
        volume_type = var.block_type_k8s
        delete_on_termination = true
    }

    tags = {
        Name = "K8s - Manager 3"
    }
}

resource "aws_instance" "worker1" {
    instance_type = var.k8s_type
    ami = var.ami 
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = "${aws_network_interface.network-worker1.id}"
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_k8s
        volume_type = var.block_type_k8s
        delete_on_termination = true
    }

    tags = {
        Name = "K8s - Worker 1"
    }
}

resource "aws_instance" "worker2" {
    instance_type = var.k8s_type
    ami = var.ami 
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = "${aws_network_interface.network-worker2.id}"
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_k8s
        volume_type = var.block_type_k8s
        delete_on_termination = true
    }

    tags = {
        Name = "K8s - Worker 2"
    }
}

resource "aws_instance" "worker3" {
    instance_type = var.k8s_type
    ami = var.ami 
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = "${aws_network_interface.network-worker3.id}"
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_k8s
        volume_type = var.block_type_k8s
        delete_on_termination = true
    }

    tags = {
        Name = "K8s - Worker 3"
    }
}

resource "aws_instance" "haproxy" {
    instance_type = var.haproxy_type
    ami = var.ami
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = "${aws_network_interface.network-haproxy.id}"
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_haproxy
        volume_type = var.block_type_haproxy
        delete_on_termination = true 
    }

    tags = {
        Name = "HAProxy"
    }
}