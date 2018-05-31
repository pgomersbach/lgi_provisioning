resource "aws_instance" "web1" {
  ami           = "${data.aws_ami.app_ami.id}"
  instance_type = "t2.micro"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids  = ["${aws_security_group.app_websg.id}"]
  availability_zone = "eu-central-1a"
  tags = {
    Terraform = "true"
    Environment = "test"
    Name = "api-1"
  }
}

resource "aws_network_interface" "secif1" {
  subnet_id       = "${element(module.vpc.private_subnets, 0)}"
  private_ips     = ["10.0.1.4"]
#  security_groups = ["${aws_security_group.web.id}"]
  attachment {
    instance     = "${aws_instance.web1.id}"
    device_index = 1
  }
}

resource "aws_lb_target_group_attachment" "testexternalweb1" {
  target_group_arn = "${aws_lb_target_group.testexternal.arn}"
  target_id        = "${aws_instance.web1.private_ip}"
  port             = 80
}
