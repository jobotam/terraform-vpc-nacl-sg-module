terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}


/** Configure Firewall Fortigate VPC **/
module "application_vpc" {
  source              = "./modules/vpc"
  tag_name            = var.tag_name
  vpc_cidr            = var.vpc_cidr
  vpc_name            = var.vpc_name
  subnet_az           = var.subnet_az
  gwlb_subnet_az       = var.gwlb_subnet_az
  gwlb_subnet_cidr     = var.gwlb_subnet_cidr
  tgw_subnet_cidr     = var.tgw_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  external_public_subnet_cidr     = var.external_public_subnet_cidr 
  internal_public_subnet_cidr      = var.internal_public_subnet_cidr 
}