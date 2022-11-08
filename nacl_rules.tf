/** Network access control list for external_public_subnet **/
module "nacl_rule_external" {
  source = "./modules/nacl_rules"
  count = "${length(var.external_public_subnet_cidr)*length(var.external_public_subnet_nacl)}"
  network_acl_id = module.application_vpc.external_public_subnet_id[floor(count.index / length(var.external_public_subnet_nacl))]
  acl_rules_in_egress = var.external_public_subnet_nacl[count.index % length(var.external_public_subnet_nacl)].egress
  acl_rules_protocol = var.external_public_subnet_nacl[count.index % length(var.external_public_subnet_nacl)].protocol
  acl_rules_rule_action = var.external_public_subnet_nacl[count.index % length(var.external_public_subnet_nacl)].rule_action
  acl_rules_rule_number = var.external_public_subnet_nacl[count.index % length(var.external_public_subnet_nacl)].rule_number
  acl_rules_from_port = var.external_public_subnet_nacl[count.index % length(var.external_public_subnet_nacl)].from_port
  acl_rules_to_port = var.external_public_subnet_nacl[count.index % length(var.external_public_subnet_nacl)].to_port
  acl_rules_cidr_block = var.external_public_subnet_nacl[count.index % length(var.external_public_subnet_nacl)].cidr_block
}