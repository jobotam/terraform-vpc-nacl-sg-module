/**Account ID **/
account_ID = ""
access_key         = "" // Pass the access key
secret_key         = "" // Pass the access secret key

/** Region **/
region  = "ap-east-1"
# kms_key = "arn:aws:kms:ap-east-1:065697780145:key/45a3f39e-605c-4914-8d43-e6b8dd1e7b77"

/** App VPC environment - subnet assignment **/
tag_name            = "hk-firewall-app"
vpc_cidr            = "10.30.16.0/20"
vpc_name            = "App-VPC"
subnet_az           = ["ap-east-1a", "ap-east-1b"]
gwlb_subnet_az       = ["ap-east-1a", "ap-east-1b"]
gwlb_subnet_cidr     = ["10.30.18.0/24", "10.30.19.0/24"]
external_public_subnet_cidr = ["10.30.16.0/24","10.30.17.0/24"]
internal_public_subnet_cidr = ["10.30.20.0/24","10.30.21.0/24"] #Firewall appliance public interface
private_subnet_cidr     = ["10.30.24.0/24", "10.30.25.0/24"]
tgw_subnet_cidr      = ["10.30.22.0/24", "10.30.23.0/24"]

instance_security_group_name =["tes-sg-01"] //Security Group names & qty of Security Groups accordinging to no. of SG's name


/** Network Access Control **/
/** External public subnet acl**/
external_public_subnet_nacl = [
  {
    egress      = false
    protocol    = "tcp"
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
  {
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    rule_number = 101
    from_port   = 443
    to_port     = 443
    cidr_block  = "0.0.0.0/0"
  },
  {
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    rule_number = 104
    from_port   = 1024
    to_port     = 65535
    cidr_block  = "10.0.137.32/32" # Ephemeral ports 
  },
  {
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    rule_number = 105
    from_port   = 1024
    to_port     = 65535
    cidr_block  = "10.0.137.36/32" # Ephemeral ports 
  },
  {
    egress      = false
    protocol    = "tcp"
    rule_action = "allow"
    rule_number = 107
    from_port   = 1024
    to_port     = 65535
    cidr_block  = "10.0.130.103/32" # Ephemeral ports 
  },
  {
    egress      = true
    protocol    = "tcp"
    rule_action = "allow"
    rule_number = 104
    from_port   = 1024
    to_port     = 65535
    cidr_block  = "10.0.130.103/32" # Ephemeral ports 
  },
]

/** Application Security group **/
sg_rules_application = [
  {
    type        = "ingress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = ["0.0.0.0/0"]
    description = "all https ingress"
  },
  {
    type        = "egress"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_block  = ["0.0.0.0/0"]
    description = "all https egress"
  },
]