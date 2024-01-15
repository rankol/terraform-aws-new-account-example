#----------
# VARIABLES
#----------

variable "account_email" {
  description = "Email address of the owner to assign to the new member account. This email address must not already be associated with another AWS account."
  type        = string
}

variable "account_name" {
  description = "Friendly name for the member account."
  type        = string
}

variable "account_owner" {
  description = "Name of the business entity that owns this account. Value will be used in tags."
  type        = string
}

variable "close_on_deletion" {
  description = "If true, a deletion event will close the account. Otherwise, it will only remove from the organization."
  type        = bool
  default     = false
}

variable "ou_parent_id" {
  description = "Parent ID of the organizational unit."
  type        = string
}

variable "ou_name" {
  description = "Name of the organizational unit."
  type        = string
}

variable "policy_json_path" {
  description = "The relative path from where Terraform initializes at which points to a JSON file that represents the policy that will be created with the templatefile() function."
  type        = string
  default     = ""
}

variable "policy_name" {
  description = "The friendly name to assign to the policy."
  type        = string
}

variable "policy_description" {
  description = "A description to assign to the policy."
  type        = string
  default     = "Policy created with Terraform."
}

variable "policy_type" {
  description = "The type of policy to create. Valid values are AISERVICES_OPT_OUT_POLICY, BACKUP_POLICY, SERVICE_CONTROL_POLICY (SCP), and TAG_POLICY. Defaults to SERVICE_CONTROL_POLICY."
  type        = string
  default     = "SERVICE_CONTROL_POLICY"
}

variable "vpc_cidr_block" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
}

variable "subnet_definition" {
  description = "A list of objects containing the subnet CIDR block and availability zone pairings."
  type = list(object({
    availability_zone = string
    cidr_block        = string
  }))
}

variable "nacl_ingress_definition" {
  description = "A list of objects containing the NACL ingress definitions."
  type = list(object({
    protocol    = string
    rule_number = number
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}

variable "nacl_egress_definition" {
  description = "A list of objects containing the NACL egress definitions."
  type = list(object({
    protocol    = string
    rule_number = number
    action      = string
    cidr_block  = string
    from_port   = number
    to_port     = number
  }))
}