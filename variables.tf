# ===================================================================
# Variables
# ===================================================================

# Documentation on variables:
# https://www.terraform.io/docs/configuration/variables.html
#
# Documentation on using them and string interpolation:
# https://www.terraform.io/docs/configuration/interpolation.html

# Example:
# variable "foo" {
#     type = "string"
#     description = "A little variable named 'foo'."
# }

variable "netid" {
    type = "string"
    description = "Contact for resources in this config."
}

variable "key_name" {
    type = "string"
    description = "EC2 Key Name for the SSH key for instances."
}

variable "instance_type" {
    type = "string"
    description = "EC2 Instance type name."
}

variable "sharedfs_id" {
    type = "string"
    description = "Elastic FileSystem ID for the shared volume."
}
