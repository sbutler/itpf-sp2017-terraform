# ===================================================================
# Resources
# ===================================================================

# Manage a single instance that we will use in all of our examples.
#
# https://www.terraform.io/docs/providers/aws/r/instance.html
resource "aws_instance" "example" {
    # Add the required attributes here, with values.
    # ami, instance_type, key_name

    ami = "${data.aws_ami.amazon_linux.id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.key_name}"

    user_data = "${data.template_cloudinit_config.userdata.rendered}"

    tags {
        Name = "${var.netid} terraform example"
        NetID = "${var.netid}"
    }
}


# ===================================================================
# Data
# ===================================================================

# Get the latest Amazon Linux AMI
#
# https://www.terraform.io/docs/providers/aws/d/ami.html
data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = [ "amazon" ]

    # All new instance types are HVM; selected only images for that type
    filter {
        name = "virtualization-type"
        values = [ "hvm" ]
    }
    # Only consider 64bit images
	filter {
        name = "architecture"
        values = [ "x86_64"]
    }

    # Add a filter that will match these "name" attribute values:
    #
    # amzn-ami-hvm-2016.09.1.20161221-x86_64-gp2
    # amzn-ami-hvm-2017.03.0.20170417-x86_64-gp2
    # amzn-ami-hvm-2016.09.0.20161028-x86_64-gp2
    # amzn-ami-hvm-2016.09.0.20160923-x86_64-gp2
    filter {
        name = "name"
        values = [ "amzn-ami-*-gp2" ]
    }
}

# Render a cloud-init config template with our EFS filesystem id
#
# https://www.terraform.io/docs/providers/template/d/file.html
data "template_file" "cloudinit_config" {
    template = "${file("templates/cloudinit_config.yml")}"

    # Add "vars" here
    vars {
        efs_id = "${var.sharedfs_id}"
    }
}

# Create a cloud-init UserData string using our rendered config above and
# including the efs.sh file as a run once script.
data "template_cloudinit_config" "userdata" {
    # MIME part for our rendered cloud-init config. Add the "content"
    # attribute to complete it.
    part {
        content_type = "text/cloud-config"
        content = "${data.template_file.cloudinit_config.rendered}"
    }

    # MIME part for the run once script that will setup the mount for our
    # EFS.
    part {
        content_type = "text/x-shellscript"
        filename = "efs.sh"
        content = "${file("files/efs.sh")}"
    }
}
