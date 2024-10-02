variable "avability_zone_a" {
  type = string
}

variable "avability_zone_b" {
  type = string
}
variable "public_subnet_cider" {
  type = list(string)
}
variable "private_subnet_cider" {
  type = list(string)
}
variable "public_subnet_name" {
  type = list(string)
}
variable "private_subnet_name" {
  type = list(string)
}

variable "sg_ports" {
  type = list(number)

}
variable "key_name" {
  type = string
}
variable "instance_type" {
  type = string

}
variable "ami_id" {
  type = string

}