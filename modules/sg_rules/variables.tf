variable "security_group_id" {
    type    = string
}

variable "ingress_egress_type" {
    type    = string
}

/**ingress variable **/
variable "rules_from_port" {
  type = number
  default = 443
}

variable "rules_to_port" {
  type = number
  default = 443
}

variable "rules_protocol" {
  type = string
  default = "tcp"
}

variable "rules_cidr_block" {
  type = list(string)
  default = ["0.0.0.0/0"]
}

variable "rules_description" {
  type = string
  default = "Allow all https"
}


