# Terraform template for an application VPC
Terraform template for an application VPC. It includes provisioning VPC, subnets, GWLB endpoints, IGW, TGW attachments and route tables.

This is a terraform template provisioned for heavy changing Network Access Control Lists (NACL) and Security Groups (SG). The module of nacl_rules and sg_rules are customised for replications of NACL and SG rules.

## Prerequisites
- Terraform v1.0.2
- jq (https://stedolan.github.io/jq/) - required for assume role only

## Deployment steps
### With AWS credential
1. Edit **terraform.tfvars**, change the access key, secret, subnet CIDR and name etc. if necessary
2. Execute the below commands to deploy:
```
terraform init
terraform plan
terraform apply
```

### With assume role (**depreciated - only available in branch *auth_assume_role***)
1. Execute the below command to assume role for getting enough permission to execute terraform:
```
source assume_role.sh <MFA token> <MFA device serial number>
```
2. Edit **terraform.tfvars**, change the subnet CIDR, name if necessary
3. Execute the below commands to deploy:
```
terraform init
terraform plan
terraform apply
```