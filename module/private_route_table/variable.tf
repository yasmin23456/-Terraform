variable "vpc_id" {
  type        = string
}

variable "nat_id" {
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
}

variable "private_rt_name" {
  type        = string
}