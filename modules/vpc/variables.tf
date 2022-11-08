
variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "vpc_name" {
  type    = string
  default = ""
}

variable "tag_name" {
  type    = string
  default = ""
}

variable "subnet_az" {
  type    = list(string)
  default = ["ap-east-1a", "ap-east-1b"]
}

variable "gwlb_subnet_az" {
  type    = list(string)
  default = ["ap-east-1a", "ap-east-1b"]
}

variable "gwlb_subnet_cidr" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24"]
}

variable "tgw_subnet_cidr" {
  type    = list(string)
  default = ["192.168.0.0/24", "192.168.1.0/24"]
}

variable "private_subnet_cidr" {
  type    = list(string)
  default = ["192.168.2.0/24", "192.168.3.0/24"]
}

variable "external_public_subnet_cidr" {
  type    = list(string)
  default = ["192.168.8.0/24", "192.168.9.0/24"]
}

variable "internal_public_subnet_cidr" {
  type    = list(string)
  default = ["192.168.8.0/24", "192.168.9.0/24"]
}

# variable "default_tag" {
#   type        = map(string)
#   description = "Default tag"
#   default     = {}
# }

# variable "db_subnet_name" {
#   type = string
# }

# variable "is_nat_required" {
#    type = bool
#    default = false
#  }

# variable "external_nat_Gateway_cidr" {
#   type = list(string)
# }

# variable "external_nat_Gateway_name" {
#   type = string
# }
# variable "bastion_subnet_inbound" {
#   type = map(list(string))
#   default = {
#     "Protocol" = ["-1"]
#     "rule_no"  = ["110"]
#     "action"   = ["allow"]
#     "cidr_block" = ["0.0.0.0/0"]
#     "from_port" = ["0"]
#     "to_port" = ["0"]
#   }
# }


# variable "bastion_subnet_outbound" {
#   type = map(list(string))
#   default = {
#     "Protocol" = ["-1"]
#     "rule_no"  = ["100"]
#     "action"   = ["allow"]
#     "cidr_block" = ["0.0.0.0/0"]
#     "from_port" = ["0"]
#     "to_port" = ["0"]
#   }
# }