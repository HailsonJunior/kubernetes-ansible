output "public_ip_manager" {
  value = aws_eip.eip-manager.id
}

output "public_ip_worker01" {
  value = aws_eip.eip-worker01.id
}

output "public_ip_worker02" {
  value = aws_eip.eip-worker02.id
}
