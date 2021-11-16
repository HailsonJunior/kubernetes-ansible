resource "aws_instance" "K8s" {
    for_each = {
        K8s- = {
            name = "Manager1"
        }
        K8s- = {
            name = "Manager2"
        }
        K8s- = {
            name = "Manager3"
        }
        K8s- = {
            name = "Worker1"
        }
        K8s- = {
            name = "Worker2"
        }
        K8s- = {
            name = "Worker3"
        }
    }

    instance_type = var.k8s_type
    ami = var.ami 
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id = 
        device_index = 0
    }

    root_block_device {
        volume_size = var.block_size_k8s
        volume_type = var.block_type_k8s
        delete_on_termination = true
    }

    tags = {
        Name = "${each.key}: ${lookup(each.value, "name", null)}"
    }
}

resource "aws_instance" "haproxy" {
    instance_type = var.haproxy_type
    ami = var.ami
    key_name = "${aws_key_pair.my-key.key_name}"
    network_interface {
        network_interface_id =
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