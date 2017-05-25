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


# ===================================================================
# Data
# ===================================================================

# Render a cloud-init config template with our EFS filesystem id
#
# https://www.terraform.io/docs/providers/template/d/file.html
/*
data "template_file" "cloudinit_config" {
    # Add "template" and "vars" here
}
*/

# Create a cloud-init UserData string using our rendered config above and
# including the efs.sh file as a run once script.
/*
data "template_cloudinit_config" "userdata" {
    # MIME part for our rendered cloud-init config. Add the "content"
    # attribute to complete it.
    part {
        content_type = "text/cloud-config"
    }

    # MIME part for the run once script that will setup the mount for our
    # EFS. Add the "filename" and "content" attributes to complete it.
    part {
        content_type = "text/x-shellscript"
    }
}
