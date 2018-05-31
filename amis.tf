data "aws_ami" "app_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["packer-example*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["656878657103"]
}
