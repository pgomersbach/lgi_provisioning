resource "aws_instance" "web1" {
  ami           = "${data.aws_ami.app_ami.id}"
  instance_type = "${var.api_instance_type}"
  key_name = "${aws_key_pair.terraform.key_name}"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids  = ["${aws_security_group.app_websg.id}"]
  availability_zone = "${var.region}a"
  iam_instance_profile = "${aws_iam_instance_profile.cloudwatch_profile.name}"
  tags = {
    Terraform = "true"
    Environment = "${var.environment}"
    Name = "api-1"
  }
}

resource "aws_lb_target_group_attachment" "testexternalweb1" {
  target_group_arn = "${aws_lb_target_group.testexternal.arn}"
  target_id        = "${aws_instance.web1.private_ip}"
  port             = 80
}

resource "aws_instance" "jump1" {
  ami           = "${data.aws_ami.jump_ami.id}"
  instance_type = "${var.jump_instance_type}"
  key_name = "${aws_key_pair.terraform.key_name}"
  subnet_id = "${element(module.vpc.public_subnets, 0)}"
  vpc_security_group_ids  = ["${aws_security_group.jump_sg.id}"]
  availability_zone = "${var.region}a"
  iam_instance_profile = "${aws_iam_instance_profile.cloudwatch_profile.name}"
  tags = {
    Terraform = "true"
    Environment = "${var.environment}"
    Name = "jumpserver"
  }
}

