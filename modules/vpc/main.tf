# Terraform configuration

resource "aws_vpc" "new_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  # tags = merge (var.default_tag, {
  #   Name = "${var.vpc_name}"
  # })
  tags = {
    Name = "${var.vpc_name}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id  = aws_vpc.new_vpc.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

# #gwlb subnet
resource "aws_subnet" "gwlb_subnet" {
  vpc_id = aws_vpc.new_vpc.id
  
  #loop the az and set the cidr accordingly
  count                   = length(var.gwlb_subnet_cidr) # create no. of AZ & public cidr according to the length of subnet az
  availability_zone       = var.gwlb_subnet_az[count.index]
  cidr_block              = var.gwlb_subnet_cidr[count.index]
  #Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = true 

  tags = {
    Name = format("${var.tag_name}-gwlb-subnet-%s","${substr(var.gwlb_subnet_az[count.index],-1,-1)}")
    } 
}

# private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.new_vpc.id

  #loop the az and set the cidr accordingly
  count                   = length(var.private_subnet_cidr) # create no. of AZ & public cidr according to the length of subnet az
  availability_zone       = var.subnet_az[count.index]
  cidr_block              = var.private_subnet_cidr[count.index]
  #Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = false 

  tags = {
    Name = format("${var.tag_name}-private-subnet-%s","${substr(var.subnet_az[count.index],-1,-1)}")
  }
}

# 1st tier public subnet 
resource "aws_subnet" "external_public_subnet" {
  vpc_id = aws_vpc.new_vpc.id

  #loop the az and set the cidr accordingly
  count                   = length(var.external_public_subnet_cidr) # create no. of AZ & public cidr according to the length of subnet az
  availability_zone       = var.subnet_az[count.index]
  cidr_block              = var.external_public_subnet_cidr[count.index]
  #Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = false 

  tags = {
    Name = format("${var.tag_name}-external-public-subnet-%s","${substr(var.subnet_az[count.index],-1,-1)}")
  }
}

# 2 nd tier public subnet 
resource "aws_subnet" "internal_public_subnet" {
  vpc_id = aws_vpc.new_vpc.id

  #loop the az and set the cidr accordingly
  count                   = length(var.internal_public_subnet_cidr) # create no. of AZ & public cidr according to the length of subnet az
  availability_zone       = var.subnet_az[count.index]
  cidr_block              = var.internal_public_subnet_cidr[count.index]
  #Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = false 

  tags = {
    Name = format("${var.tag_name}-internal-public-subnet-%s","${substr(var.subnet_az[count.index],-1,-1)}")
  }
}

# TGW subnet
resource "aws_subnet" "tgw_subnet" {
  vpc_id = aws_vpc.new_vpc.id

  #loop the az and set the cidr accordingly
  count                   = length(var.tgw_subnet_cidr) # create no. of AZ & public cidr according to the length of subnet az
  availability_zone       = var.subnet_az[count.index]
  cidr_block              = var.tgw_subnet_cidr[count.index]
  #Specify true to indicate that instances launched into the subnet should be assigned a public IP address.
  map_public_ip_on_launch = false 

  tags = {
    Name = format("${var.tag_name}-tgw-subnet-%s","${substr(var.subnet_az[count.index],-1,-1)}")
  }
}



/** ------------------------------------Routetable for each VPC------------------------------------------------------------------------- **/

#Create public subnet route table
resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.new_vpc.id
  # route = [
  # ]

  tags = {
    Name = "${var.tag_name}-public-rtb"
  }
}

# Create privte (VST, Bastion host, DB) subnet route table
resource "aws_route_table" "private_rtb" {
  vpc_id        = aws_vpc.new_vpc.id
  
  tags = {
    Name = "${var.tag_name}-private-rtb"
  }
}

# Assocciate public subnet to route table 
resource "aws_route_table_association" "gwlb_subnet" {
  count          = length(var.gwlb_subnet_cidr)
  subnet_id      = aws_subnet.gwlb_subnet[count.index].id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public_subnet" {
  count          = length(var.external_public_subnet_cidr)
  subnet_id      = aws_subnet.external_public_subnet[count.index].id
  route_table_id = aws_route_table.public_rtb.id
}

resource "aws_route_table_association" "public_subnet_2" {
  count          = length(var.internal_public_subnet_cidr)
  subnet_id      = aws_subnet.internal_public_subnet[count.index].id
  route_table_id = aws_route_table.public_rtb.id
}

# Assocciate private subnet to route table 
resource "aws_route_table_association" "private_subnet" {
  count          = length(var.private_subnet_cidr)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rtb.id
}


# Assocciate private subnet (tgw) to route table 
resource "aws_route_table_association" "tgw_subnet" {
  count          = length(var.tgw_subnet_cidr)
  subnet_id      = aws_subnet.tgw_subnet[count.index].id
  route_table_id = aws_route_table.private_rtb.id
}

/** ------------------------------------Network ACL for each subnet------------------------------------------------------------------------- **/
# resource "aws_network_acl" "alb_nacl" {
#   vpc_id         = aws_vpc.new_vpc.id
#   count          = length(var.alb_subnet_cidr)
#   subnet_ids     = [aws_subnet.alb_subnet[count.index].id]
 
#   tags = {
#     Name = "${var.vpc_name}-alb_subnet_nacl"
#   }
# }


# resource "aws_network_acl" "bastion_subnet_nacl" {
#   vpc_id         = aws_vpc.new_vpc.id
#   count          = length(var.bastion_subnet_cidr)
#   subnet_ids     = [aws_subnet.bastion_subnet[count.index].id]
 
#   tags = {
#     Name = "${var.vpc_name}-bastion_subnet_nacl"
#   }
# }

# resource "aws_network_acl" "ecs_subnet_nacl" {
#   vpc_id         = aws_vpc.new_vpc.id
#   count          = length(var.ecs_subnet_cidr)
#   subnet_ids     = [aws_subnet.ecs_subnet[count.index].id]
 
#   tags = {
#     Name = "${var.vpc_name}-ecs_subnet_nacl"
#   }
# }

# # DB NACL
# resource "aws_network_acl" "db_subnet_nacl" {
#   vpc_id         = aws_vpc.new_vpc.id
#   count          = length(var.db_subnet_cidr)  #"${length(var.db_subnet_cidr)*length(var.bastion_subnet_cidr)}"
#   subnet_ids     = [aws_subnet.db_subnet[count.index].id]

#   tags = {
#     Name = "${var.vpc_name}-db_subnet_nacl"
#   }
# }

# # DB-backup zone NACL
# resource "aws_network_acl" "db_subnet_nacl_b" {
#   vpc_id         = aws_vpc.new_vpc.id
#   count          = length(var.db_subnet_cidr_b)  #"${length(var.db_subnet_cidr)*length(var.bastion_subnet_cidr)}"
#   subnet_ids     = [aws_subnet.db_subnet_b[count.index].id]

#   tags = {
#     Name = "${var.vpc_name}-db_subnet_nacl_b"
#   }
# }

# resource "aws_network_acl" "transit_nacl" {
#   vpc_id         = aws_vpc.new_vpc.id
#   count          = length(var.tgw_subnet_cidr)
#   subnet_ids     = [aws_subnet.tgw_subnet[count.index].id]


#   /** Allow inbound traffic NACL */
#   ingress = [
#     {
#       protocol = -1
#       rule_no = 100
#       action = "allow"
#       cidr_block = "0.0.0.0/0"
#       from_port = 0
#       to_port = 0
#       ipv6_cidr_block = null
#       icmp_type = 0
#       icmp_code = 0
#     }
#   ]


#   /** Allow outbound traffic NACL */
#   egress = [
#     {
#       protocol = -1
#       rule_no = 100
#       action = "allow"
#       cidr_block = "0.0.0.0/0"
#       from_port = 0
#       to_port = 0
#       ipv6_cidr_block = null
#       icmp_type = 0
#       icmp_code = 0
#     }
#   ]
#   tags = {
#     Name = "${var.vpc_name}-tgw_nacl"
#   }
# }




