
resource "aws_security_group" "application_sg" {
  count       = length(var.instance_security_group_name)
  name        = var.instance_security_group_name[count.index]
  description = "Allow inbound_outbound traffic to access bastion host"
  vpc_id      = module.application_vpc.vpc_id
  tags = {
    Name = "${var.vpc_name}-${var.instance_security_group_name[count.index]}"
  }
}

/** Secuirty group - for virtual appliance**/
module "application_sg_rule_1" {
  source = "./modules/sg_rules"
  count = length(var.sg_rules_application)

  ingress_egress_type = var.sg_rules_application[count.index].type
  rules_from_port = var.sg_rules_application[count.index].from_port
  rules_to_port = var.sg_rules_application[count.index].to_port
  rules_protocol = var.sg_rules_application[count.index].protocol
  rules_cidr_block = var.sg_rules_application[count.index].cidr_block
  rules_description = var.sg_rules_application[count.index].description
  security_group_id = aws_security_group.application_sg[0].id
}

