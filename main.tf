module "vpc" {
  source     = "./module/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "my_vpc"
}
#################### public subnet###############################
module "public_subnet_1" {
  source         = "./module/subnets"
  vpc_id         = module.vpc.vpc_id
  avability_zone = var.avability_zone_a
  map_public     = true
  subnet_cidr    = var.public_subnet_cider[0]
  subnet_name    = var.public_subnet_name[0]
  # depends_on     = [module.vpc]
}

module "public_subnet_2" {
  source         = "./module/subnets"
  vpc_id         = module.vpc.vpc_id
  avability_zone = var.avability_zone_b
  map_public     = true
  subnet_cidr    = var.public_subnet_cider[1]
  subnet_name    = var.public_subnet_name[1]
  # depends_on     = [module.vpc]
}
#################### private subnet###############################

module "private_subnet_1" {
  source         = "./module/subnets"
  vpc_id         = module.vpc.vpc_id
  avability_zone = var.avability_zone_a
  map_public     = false
  subnet_cidr    = var.private_subnet_cider[0]
  subnet_name    = var.private_subnet_name[0]
  depends_on     = [module.vpc]
}

module "private_subnet_2" {
  source         = "./module/subnets"
  vpc_id         = module.vpc.vpc_id
  avability_zone = var.avability_zone_b
  map_public     = false

  subnet_cidr = var.private_subnet_cider[1]
  subnet_name = var.private_subnet_name[1]
  # depends_on  = [module.vpc]
}

#################### internet gateway ###############################
module "igw" {
  source   = "./module/IGW"
  vpc_id   = module.vpc.vpc_id
  igw_name = "IGW"
  # depends_on = [module.vpc]
}

####################public route table ###############################

module "public_route_table" {
  source              = "./module/public_route_table"
  vpc_id              = module.vpc.vpc_id
  internet_gateway_id = module.igw.internet_gateway_id
  p_rt_name           = "Public_rt"
  subnet_ids          = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  # depends_on          = [module.vpc, module.public_subnet_1, module.public_subnet_2, module.igw]

}
########################## nat gateway #################################

module "natGateway" {
  source           = "./module/nat gatway"
  nat_name         = "Nat Gateway"
  public_subnet_id = module.public_subnet_1.subnet_id
  # depends_on       = [module.public_subnet_1]

}

########################## private route table  #################################
module "private_rt" {
  source          = "./module/private_route_table"
  nat_id          = module.natGateway.nat_gw_id
  private_rt_name = "Private route table  "
  subnet_ids      = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  vpc_id          = module.vpc.vpc_id
  # depends_on      = [module.vpc, module.natGateway, module.private_subnet_1, module.private_subnet_2]
}

########################## security group #################################

module "sg" {
  source   = "./module/security_group"
  vpc_id   = module.vpc.vpc_id
  sg_ports = var.sg_ports
  # depends_on = [module.vpc]
}

# ########################## key_pair #################################
module "key" {
  source   = "./module/key_pair"
  key_name = var.key_name

}

########################## public ec2 #################################
module "public_ec2" {
  source                      = "./module/public_ec2"
  ec2_count                   = 2
  alb_dns_name                = module.Public_Load_Balancer.dns_name
  ami_id                      = var.ami_id
  associate_public_ip_address = true
  instance_type               = var.instance_type
  subnet_id                   = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  sg_id                       = module.sg.sg_id
  key_name                    = var.key_name
  ec2_name                    = ["Public instance 1", "Public instance 2"]
  # depends_on                  = [module.public_subnet_1, module.public_subnet_2, module.sg,module.Public_Load_Balancer]
}
#########################3 private ec2#########################################
module "private_ec2" {
  source                      = "./module/private_ec2"
  ec2_count                   = 2
  ami_id                      = var.ami_id
  associate_public_ip_address = false
  instance_type               = var.instance_type
  subnet_id                   = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  sg_id                       = module.sg.sg_id
  key_name                    = var.key_name


  ec2_name = ["Private  instance 1", "Private instance 2"]
  # depends_on = [module.private_subnet_1, module.private_subnet_2, module.sg,module.private_Load_Balancer]
}

###################################public LOAD Balancer##################################
module "Public_Load_Balancer" {
  source = "./module/load_balancer"

  alb_name          = "Public-Load-Balancer"
  ec2_count         = 2
  ec2_id            = module.public_ec2.ec2_ids
  subnet_id         = [module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id]
  internal          = false
  sg_id             = module.sg.sg_id
  target_group_name = "ALB-target-group-public"
  vpc_id            = module.vpc.vpc_id
  # depends_on        = [module.public_ec2, module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id, module.vpc, module.sg]



}

###################################private  LOAD Balancer##################################
module "private_Load_Balancer" {
  source            = "./module/load_balancer"
  alb_name          = "Private-Load-Balancer"
  ec2_count         = 2
  ec2_id            = module.private_ec2.ec2_ids
  subnet_id         = [module.private_subnet_1.subnet_id, module.private_subnet_2.subnet_id]
  internal          = true
  sg_id             = module.sg.sg_id
  target_group_name = "ALB-target-group-private"
  vpc_id            = module.vpc.vpc_id
  # depends_on        = [module.public_ec2, module.public_subnet_1.subnet_id, module.public_subnet_2.subnet_id, module.vpc, module.sg]

}