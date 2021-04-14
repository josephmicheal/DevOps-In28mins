data "aws_subnet_ids" "default_subnets" {
  vpc_id = aws_default_vpc.default.id
}

data "aws_ami_ids" "aws_linux_2_latest_ids" {
  owners = ["amazon"]
}

data "aws_ami" "aws_linux_2_latest" {
  owners      = ["amazon"] # only from amazon
  most_recent = true       # to get latest one
  filter {                 # filter using name as given in values
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}