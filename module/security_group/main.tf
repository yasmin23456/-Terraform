resource "aws_security_group" "SG" {
    vpc_id = var.vpc_id
    count = length(var.sg_ports)
    ingress {
        from_port = var.sg_ports[count.index]
        to_port = var.sg_ports[count.index]
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        
    }
      tags = {
      Name="A: SG"
    }
  
}