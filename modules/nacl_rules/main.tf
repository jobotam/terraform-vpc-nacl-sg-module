resource "aws_network_acl_rule" "nacl_rules" {
network_acl_id = var.network_acl_id
egress = var.acl_rules_in_egress
protocol = var.acl_rules_protocol
rule_action = var.acl_rules_rule_action
rule_number = var.acl_rules_rule_number
from_port = var.acl_rules_from_port
to_port = var.acl_rules_to_port
cidr_block = var.acl_rules_cidr_block
}

