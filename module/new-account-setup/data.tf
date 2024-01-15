#------------
# DATA BLOCKS
#------------

data "aws_organizations_organizational_unit" "organizational_unit" {
  parent_id = var.ou_parent_id
  name      = var.ou_name
}