#output "http_server_public_dns" {
#value = aws_instance.http_server.*.public_dns
#}

output "http_server_public_dns" {
  value = values(aws_instance.http_server).*.id
}



#output "http_server_elb_public_dns" {
# value = aws_elb.http_server_elb
#}