# ===================================================================
# Outputs
# ===================================================================

# Outputs will be shown at the end of every terraform apply, and also on demand
# by running terraform output. In more advanced usage, outputs are also
# available in remote state for use in other terraform configurations.
#
# Documentation on outputs:
# https://www.terraform.io/docs/configuration/outputs.html

# Example:
# output "foo" {
#     value = "${var.foo}"
# }

output "example_id" {
    value = "${aws_instance.example.id}"
}

output "example_public_ip" {
    value = "${aws_instance.example.public_ip}"
}
