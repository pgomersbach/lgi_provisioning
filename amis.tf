data "aws_ami" "app_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.app_ami_name}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.ami_owner}"]
}

data "aws_ami" "jump_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.jump_ami_name}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.ami_owner}"]
}

data "aws_ami" "rapid7_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["${var.rapid7_ami_name}"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["${var.rapid7_ami_owner}"]
}
