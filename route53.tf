data "aws_route53_zone" "selected" {
  name = "${var.hosted_zone}"
}

resource "aws_route53_record" "api" {
  zone_id = "${data.aws_route53_zone.selected.zone_id}"
  name    = "${var.environment}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  alias {
    name                   = "${aws_lb.nlb1.dns_name}"
    zone_id                = "${aws_lb.nlb1.zone_id}"
    evaluate_target_health = true
  }
}
