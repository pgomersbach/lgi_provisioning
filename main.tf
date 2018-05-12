variable "access_key" {}
variable "secret_key" {}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "eu-central-1"
}

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

resource "aws_launch_template" "app_lt" {
  image_id = "${data.aws_ami.app_ami.id}"
  instance_type = "t2.micro"
  monitoring {
    enabled = false
  }
  vpc_security_group_ids = ["${aws_security_group.app_websg.id}"]
  tag_specifications {
    resource_type = "instance"
    tags {
      Role = "api instance"
    }
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  name                 = "terraform-asg-app-${data.aws_ami.app_ami.id}"
  # name                 = "terraform-asg-app-${aws_launch_template.app_lt.name}"
  availability_zones = ["${data.aws_availability_zones.allzones.names}"]
  min_size             = 2
  max_size             = 2
  load_balancers = ["${aws_elb.elb1.id}"]
  health_check_type = "ELB"
  launch_template = {
    id = "${aws_launch_template.app_lt.id}"
    version = "$$Latest"
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "app_websg" {
  name = "security_group_for_app_sg"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "elbsg" {
  name = "security_group_for_elb"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_availability_zones" "allzones" {}

resource "aws_elb" "elb1" {
  name = "terraform-elb-app"
  availability_zones = ["${data.aws_availability_zones.allzones.names}"]
  security_groups = ["${aws_security_group.elbsg.id}"]
  
  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "TCP:80"
      interval = 30
  }

  cross_zone_load_balancing = true
  idle_timeout = 400
  connection_draining = true
  connection_draining_timeout = 400

  tags {
    Name = "terraform - elb - app"
  }
}
