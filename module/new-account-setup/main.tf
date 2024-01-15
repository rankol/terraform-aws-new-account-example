#------------
# AWS ACCOUNT
#------------

resource "aws_organizations_account" "account" {
  email             = var.account_email
  name              = var.account_name
  close_on_deletion = var.close_on_deletion
  parent_id         = data.aws_organizations_organizational_unit.organizational_unit.id
  tags              = local.common_tags
}

#---------------
# ACCOUNT POLICY
#---------------

resource "aws_organizations_policy" "policy" {
  count       = length(var.policy_json_path) == 0 ? 0 : 1
  content     = templatefile(var.policy_json_path, {})
  name        = var.policy_name
  description = var.policy_description
  type        = var.policy_type
  tags        = local.common_tags
}

#--------------------------
# ACCOUNT POLICY ATTACHMENT
#--------------------------

resource "aws_organizations_policy_attachment" "account" {
  policy_id = aws_organizations_policy.policy.*.id
  target_id = aws_organizations_account.account.id
}

#-----------
# CUSTOM VPC
#-----------

resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
}

#--------------
# CUSTOM SUBNET
#--------------

resource "aws_subnet" "subnet" {
  for_each          = toset(var.subnet_definition)
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
  vpc_id            = aws_vpc.vpc.id
}

#------------
# CUSTOM NACL
#------------

// THIS WOULD BE USED TO APPLY A COMMON NACL TO ALL SUBNETS IN THE
// aws_subnet RESOURCE DUE TO RESOURCE REFERENCE IN subnet_ids

resource "aws_network_acl" "nacl" {
  vpc_id     = aws_vpc.vpc.id
  subnet_ids = aws_subnet.subnet.*.id
  tags       = local.common_tags

  dynamic "ingress" {
    for_each = var.nacl_ingress_definition
    content {
      protocol   = ingress.value.protocol
      rule_no    = ingress.value.rule_number
      action     = ingress.value.action
      cidr_block = ingress.value.cidr_block
      from_port  = ingress.value.from_port
      to_port    = ingress.value.to_port
    }
  }

  dynamic "egress" {
    for_each = var.nacl_egress_definition
    content {
      protocol   = egress.value.protocol
      rule_no    = egress.value.rule_number
      action     = egress.value.action
      cidr_block = egress.value.cidr_block
      from_port  = egress.value.from_port
      to_port    = egress.value.to_port
    }
  }
}