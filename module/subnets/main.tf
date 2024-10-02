resource "aws_subnet" "subnets" {
  vpc_id     = var.vpc_id
  cidr_block = var.subnet_cidr
  availability_zone = var.avability_zone

  map_public_ip_on_launch = var.map_public

  tags = {
    Name = var.subnet_name
  }
}