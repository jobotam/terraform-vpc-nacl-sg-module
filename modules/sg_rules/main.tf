resource "aws_security_group_rule" "ingress_rules" {
  type              = var.ingress_egress_type
  from_port         = var.rules_from_port
  to_port           = var.rules_to_port
  protocol          = var.rules_protocol
  cidr_blocks       = var.rules_cidr_block
  security_group_id = var.security_group_id
  description       = var.rules_description
}

