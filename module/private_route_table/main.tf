resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_id
  }

  tags = {
    Name = var.private_rt_name
  }
}

resource "aws_route_table_association" "private_association" {
  count      = length(var.subnet_ids)
  subnet_id  = var.subnet_ids[count.index]
  route_table_id = aws_route_table.private_rt.id
}