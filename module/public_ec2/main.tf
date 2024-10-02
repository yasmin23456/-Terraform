data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]  # Canonical (Ubuntu) owner ID
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
resource "aws_instance" "ec2" {
  count         = var.ec2_count
  # ami           = var.ami_id
  ami =data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id[count.index]
  security_groups = var.sg_id
  key_name      = var.key_name
  associate_public_ip_address = var.associate_public_ip_address

  user_data = var.user_data 
  

  tags = {
    Name = var.ec2_name[count.index]
  }

  # "sudo mkdir -p /var/www/html",

# provisioner "file" {
#   source      = "index.html"
#   destination = "/var/www/html/index.html"

#   connection {
#     type        = "ssh"
#     user        = "ubuntu"  # or the appropriate user for your AMI
#     private_key = file("ayakey.pem")
#     host        = self.public_ip
#   }
# }

  provisioner "local-exec" {
    command = "echo 'public-ip :  ${self.public_ip}' >> all-ips.txt "
  }
  }