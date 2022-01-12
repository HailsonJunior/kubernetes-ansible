output "public_ip_manager" {
  value = aws_spot_instance_request.manager.public_ip
}

output "public_ip_worker01" {
  value = aws_spot_instance_request.worker01.public_ip
}

output "public_ip_worker02" {
  value = aws_spot_instance_request.worker02.public_ip
}
