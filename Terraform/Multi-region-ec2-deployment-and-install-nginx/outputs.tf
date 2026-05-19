output "mumbai_public_ip" {
  value = aws_instance.mumbai_server.public_ip
}

output "virginia_public_ip" {
  value = aws_instance.virginia_server.public_ip
}
