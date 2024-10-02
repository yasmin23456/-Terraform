output "ec2_ids" {
  description = "The IDs of the launched instances"

  value = aws_instance.ec2[*].id
}