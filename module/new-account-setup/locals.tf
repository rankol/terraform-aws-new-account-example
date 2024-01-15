#-------
# LOCALS
#-------

locals {
  common_tags = {
    "account_owner" = var.account_owner
    "account_name"  = var.account_name
  }
}