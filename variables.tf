variable "region" {
  type    = string
  default = "ap-east-1" #default is Hong Kong region
}


variable "account_ID" {
  type = string
}

variable "access_key" {
  type = string
}

variable "secret_key" {
  type = string
}

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

variable "instance_security_group_name" {
  type    = list(string)
  default = ["sg-01", "sg-02"]
}

/** Network ACL paramenter  subnet **/
variable "external_public_subnet_nacl" {
  type = list(object({
    egress      = string
    protocol    = string
    rule_action = string
    rule_number = number
    from_port   = number
    to_port     = number
    cidr_block  = string
  }))
  default = [
    {
      egress      = false
      protocol    = "rdp"
      rule_action = "allow"
      rule_number = 100
      from_port   = 3389
      to_port     = 3389
      cidr_block  = "0.0.0.0/0"
    },
    {
      egress      = true
      protocol    = "-1"
      rule_action = "allow"
      rule_number = 100
      from_port   = 0
      to_port     = 0
      cidr_block  = "0.0.0.0/0"

    },
  ]
}

/** Secuirty group of Bastion host **/
variable "sg_rules_application" {
  type = list(object({
    type        = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_block  = list(string)
    description = string
  }))
  default = [
    {
      type        = "egress"
      from_port   = 0
      to_port     = 0
      protocol    = -1
      cidr_block  = ["0.0.0.0/0"]
      description = "Allow all"
    },
  ]
}