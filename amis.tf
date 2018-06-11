data "aws_ami" "app_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["${var.ami_name}"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["${var.ami_owner}"]
}
