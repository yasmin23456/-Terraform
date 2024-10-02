variable "vpc_id" {
  type        = string
}

variable "internet_gateway_id" {
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
}

variable "p_rt_name" {
  type        = string
}