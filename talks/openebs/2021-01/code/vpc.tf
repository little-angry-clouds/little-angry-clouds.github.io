module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = "openebs-poc"
  cidr = "19.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["19.0.1.0/24", "19.0.2.0/24", "19.0.3.0/24"]
  public_subnets  = ["19.0.101.0/24", "19.0.102.0/24", "19.0.103.0/24"]

  enable_nat_gateway     = true
  single_nat_gateway     = true
  one_nat_gateway_per_az = false

  enable_dns_hostnames = true
  enable_dns_support   = true
}
