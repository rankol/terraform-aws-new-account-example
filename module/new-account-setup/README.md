# Terraform Repository for Provisioning New AWS Accounts

## Purpose

The purpose of this module is to provision a new AWS account in an Organizational Unit of an AWS Organization. Other resources such as organizational policies, policy attachment to the account, VPC, subnets, and Network ACLs are also provisioned from this module.

## Usage

Below is an example of how to use this module.

```hcl
module "new-account-setup" {
    source = "<RELATIVE_PATH_TO_MODULE>"

    ou_parent_id = ""
    ou_name = ""
    account_email = ""
    account_name = ""
    ...
    ...
    policy_json_path = "<RELATIVE_PATH_TO_JSON_POLICY>"
    policy_name = ""
    policy_type = ""
    ...
    ...
    vpc_cidr_block = ""
    subnet_definition = [
        {
            availability_zone = ""
            cidr_block = ""
        },
        ...
        ...
    ]
    nacl_ingress_definition = [
        {
            protocol = ""
            action = ""
            ...
            ...
        },
        ...
        ...
    ]
}
```