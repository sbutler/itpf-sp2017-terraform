# ===================================================================
# Resources
# ===================================================================

# Manage a single instance that we will use in all of our examples.
#
# https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "example" {
    # Add the required attributes here, with values.
    # ami, instance_type, key_name
}
