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

output "jumphost" {
  description = "Jump server address"
  value       = "${aws_instance.jump1.public_ip}"
}

output "SSH connect string app1 server" {
  value = "ssh -i ${var.ssh_key_file} ${var.app_username}@${aws_instance.api.0.private_ip} -o 'ProxyCommand ssh -A -i ${var.ssh_key_file} ${var.jump_username}@${aws_instance.jump1.public_ip} -W ${aws_instance.api.0.private_ip}:22' "
}
