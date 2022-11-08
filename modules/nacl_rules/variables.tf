/** network acl id**/
variable "network_acl_id" {
    type    = string
}

/** acl parameters**/
variable "acl_rules_in_egress" {
    type    = string
    default = "true"
}

variable "acl_rules_protocol" {
    type    = string
    default = "-1"
}

variable "acl_rules_rule_action" {
    type    = string
    default = "allow"
}

variable "acl_rules_rule_number" {
    type    = number
    default = 101
}

variable "acl_rules_from_port" {
    type    = number
    default = 0
}

variable "acl_rules_to_port" {
    type    = number
    default = 0
}

variable "acl_rules_cidr_block" {
    type    = string
    default = "0.0.0.0/0" 
}