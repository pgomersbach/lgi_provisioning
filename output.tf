output "vpc_id" {
  description = "VPC IDs"
  value       = ["${module.vpc.vpc_id}"]
}

output "private_subnets" {
  description = "List of IDs of private subnets"
  value       = ["${module.vpc.private_subnets}"]
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = ["${module.vpc.public_subnets}"]
}

output "lb_public" {
  description = "Load balancer public A record"
  value       = "${aws_lb.nlb1.dns_name}"
}
