module "flow_logs" {
  source = "github.com/GSA/terraform-vpc-flow-log"
  vpc_id = "${module.vpc.vpc_id}"
  prefix = "akana-vpc-${var.environment}"
}
