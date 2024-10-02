output "public_lb_dns" {
  value = module.Public_Load_Balancer.dns_name
}

output "private_lb_dns" {
  value = module.private_Load_Balancer.dns_name
}