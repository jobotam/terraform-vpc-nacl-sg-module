output "vpc_id" {
  value       = aws_vpc.new_vpc.id
  description = "The VPC ID."
}

output "vpc_default_route_table_id" {
  value       = aws_vpc.new_vpc.default_route_table_id
  description = "VPC default route table id"
}

output "gwlb_subnet_id" {
  value       = aws_subnet.gwlb_subnet.*.id
  description = "The gwlb subnet ID."
}

output "private_subnet_id" {
  value       = aws_subnet.private_subnet.*.id
  description = "The private subnet ID."
}

output "external_public_subnet_id" {
  value       = aws_subnet.external_public_subnet.*.id
  description = "The public subnet ID."
}

output "internal_public_subnet_id" {
  value = aws_subnet.internal_public_subnet.*.id
  description = "The FW or WAF public subnet ID."
}

output "tgw_subnet_id" {
  value       = aws_subnet.tgw_subnet.*.id
  description = "The private subnet ID."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.igw.*.id
  description = "The internet gateway ID."
}

# output "nat_gateway_id" {
#   value = aws_nat_gateway.nat.*.id
#   description = "The NAT gateway ID."
# }

# output "nat_IP" {
#   value = aws_eip.nat_gateway.*.ids
#   description = "The NAT gateway IP."
# }

output "public_route_table_id" {
  value       = aws_route_table.public_rtb.id
  description = "Public route table id."
}

output "private_route_table_id" {
  value       = aws_route_table.private_rtb.id
  description = "Private route table id."
}

# output "alb_subnet_nacl_id" {
#   value       = aws_network_acl.alb_nacl.*.id
#   description = "alb subnet nacl id."
# }

# output "alb_subnet_nacl_arn" {
#   value       = aws_network_acl.alb_nacl.*.arn
#   description = "alb subnet nacl arn."
# }

# output "bastion_subnet_nacl_id" {
#   value       = aws_network_acl.bastion_subnet_nacl.*.id
#   description = "Bastion subnet nacl id."
# }

# output "bastion_subnet_nacl_arn" {
#   value       = aws_network_acl.bastion_subnet_nacl.*.arn
#   description = "Bastion subnet nacl arn."
# }

# output "ecs_subnet_nacl_id" {
#   value       = aws_network_acl.ecs_subnet_nacl.*.id
#   description = "ECSn subnet nacl id."
# }

# output "ecs_subnet_nacl_arn" {
#   value       = aws_network_acl.ecs_subnet_nacl.*.arn
#   description = "ECS subnet nacl arn."
# }

# output "db_subnet_nacl_id" {
#   value       = aws_network_acl.db_subnet_nacl.*.id
#   description = "ECSn subnet nacl id."
# }

# output "db_subnet_nacl_arn" {
#   value       = aws_network_acl.db_subnet_nacl.*.arn
#   description = "DB subnet nacl arn."
# }

# output "db_subnet_b_nacl_id" {
#   value       = aws_network_acl.db_subnet_nacl_b.*.id
#   description = "ECSn subnet nacl id."
# }

# output "db_subnet_b_nacl_arn" {
#   value       = aws_network_acl.db_subnet_nacl_b.*.arn
#   description = "DB subnet nacl arn."
# }

output "default_security_group_id" {
  value       = aws_vpc.new_vpc.default_security_group_id
  description = "Default security group id"
}
