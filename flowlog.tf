resource "random_string" "flow-log-name" {
  length  = 16
  special = false
}

module "flow_logs" {
  source         = "github.com/GSA/terraform-vpc-flow-log"
  vpc_id         = "${module.vpc.vpc_id}"
  log_group_name = "akana-vpc-flowlog${var.environment}${random_string.flow-log-name.result}"
  prefix         = "akana-vpc-flowlog${var.environment}${random_string.flow-log-name.result}"
}
