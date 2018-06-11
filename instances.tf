resource "aws_instance" "web1" {
  ami           = "${data.aws_ami.app_ami.id}"
  instance_type = "${var.api_instance_type}"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids  = ["${aws_security_group.app_websg.id}"]
  availability_zone = "${var.region}a"
  tags = {
    Terraform = "true"
    Environment = "${var.environment}"
    Name = "api-1"
  }
}

resource "aws_network_interface" "secif1" {
  subnet_id       = "${element(module.vpc.private_subnets, 0)}"
  private_ips     = ["10.0.1.4"]
  security_groups = ["${aws_security_group.mon_sg.id}"]
  attachment {
    instance     = "${aws_instance.web1.id}"
    device_index = 1
  }
  tags = {
    Terraform = "true"
    Environment = "${var.environment}"
    Name = "api-if1"
  }
}

resource "aws_lb_target_group_attachment" "testexternalweb1" {
  target_group_arn = "${aws_lb_target_group.testexternal.arn}"
  target_id        = "${aws_instance.web1.private_ip}"
  port             = 80
}
