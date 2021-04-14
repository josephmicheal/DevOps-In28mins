output "http_server_public_dns" {
  value = aws_instance.http_server.public_dns
}