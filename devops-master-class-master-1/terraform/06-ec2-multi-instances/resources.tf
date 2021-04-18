resource "aws_default_vpc" "default" {

}


resource "aws_security_group" "http_server_sg" {

  name   = "http_server_sg"
  vpc_id = aws_default_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "AWS Security Group for HTTP Server Port 8080 Ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "AWS Security Group for HTTP Server Port 22 Ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "AWS Security Group for HTTP Server egress"
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }

  tags = {
    "Name" = "http_server_sg"
  }
}

#new security group for load balancer
resource "aws_security_group" "aws_elb_security_group" {

  name   = "aws_elb_security_group"
  vpc_id = aws_default_vpc.default.id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "AWS Security Group for HTTP Server Port 8080 Ingress"
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
  }

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "AWS Security Group for HTTP Server Port 22 Ingress"
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    description = "AWS Security Group for HTTP Server egress"
    from_port   = 0
    to_port     = 0
    protocol    = -1
  }
}

resource "aws_elb" "http-server-elb" {

  name            = "http-server-elb"
  subnets         = data.aws_subnet_ids.default_subnets.ids
  security_groups = [aws_security_group.aws_elb_security_group.id]
  instances       = values(aws_instance.http_server).*.id

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
}

resource "aws_instance" "http_server" {
  ami                    = data.aws_ami.aws_linux_2_latest.id     # from initial screen for linux server
  key_name               = "aws_ssh_key"                          # created ssh key name
  instance_type          = "t2.micro"                             # from second screen
  vpc_security_group_ids = [aws_security_group.http_server_sg.id] # from above

  #subnet_id              = tolist(data.aws_subnet_ids.default_subnets.ids)[4] # from VPC

  #for each subnet now we have to create ec2 instace as below

  for_each  = data.aws_subnet_ids.default_subnets.ids
  subnet_id = each.value

  tags = {
    name = "http_servers_${each.value}"
  }


  connection {
    type        = "ssh"
    host        = self.public_ip # can be taken from state file
    user        = "ec2-user"
    private_key = file(var.aws_key_pair)
  }


  provisioner "remote-exec" {
    inline = [
      "sudo yum install httpd -y",
      "sudo service httpd start",
      "echo Welcome to in28minutes - at ${self.public_dns} | sudo tee /var/www/html/index.html"
    ]
  }

}