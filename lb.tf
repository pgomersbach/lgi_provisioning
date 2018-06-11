resource "aws_lb_target_group" "testexternal" {
  name     = "testexternal"
  protocol = "TCP"
  port     = 80
  vpc_id   = "${module.vpc.vpc_id}"
  target_type = "ip"
  health_check {
      protocol            = "TCP"
      healthy_threshold   = 10
      unhealthy_threshold = 10
      interval            = 10
  }
  tags = {
    Terraform = "true"
    Environment = "${var.environment}"
    Name = "lb_target_group"
  }
}

resource "aws_lb" "nlb1" {
  name               = "terraform-nlb-api"
  internal           = false
  load_balancer_type = "network"
  enable_cross_zone_load_balancing = true
  subnet_mapping {
    subnet_id    = "${element(module.vpc.public_subnets, 0)}"
  }
  subnet_mapping {
    subnet_id    = "${element(module.vpc.public_subnets, 1)}"
  }
  tags {
    Terraform = "true"
    Environment = "${var.environment}"
    Name = "terraform - nlb - app"
  }
}

resource "aws_lb_listener" "testexternal" {
  load_balancer_arn = "${aws_lb.nlb1.arn}"
  protocol          = "TCP"
  port              = "80"
  default_action {
    target_group_arn = "${aws_lb_target_group.testexternal.arn}"
    type             = "forward"
  }
}
