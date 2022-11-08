output "ingress_rule_id" {
  value = aws_security_group_rule.ingress_rules.*.id
  description = "The ingress rule ID."
}
