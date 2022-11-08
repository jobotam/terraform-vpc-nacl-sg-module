output "acl_rule_id" {
  value = aws_network_acl_rule.nacl_rules.*.id
  description = "The acl rule ID."
}

