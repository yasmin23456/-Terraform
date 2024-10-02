variable "alb_name" {
  type        = string
}

variable "internal" {
  type        = bool
}

variable "subnet_id" {
  type        = list(string)
}

variable "ec2_count" {
  type        = number
  
}

variable "ec2_id" {
  type        = list(string)
}
variable "sg_id" {
  type        = list(string)
}

variable "target_group_name" {
  type        = string
}



variable "vpc_id" {
  type        = string
}
