module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "v13.0.0"
  cluster_name    = "openebs-poc"
  cluster_version = "1.17"
  subnets         = concat(module.vpc.private_subnets, module.vpc.public_subnets)
  vpc_id          = module.vpc.vpc_id
  worker_groups = [
    {
      asg_desired_capacity = 2
      asg_max_size         = 2
      asg_min_size         = 2
      instance_type        = "t3.medium"
      name                 = "openebs-poc"
      subnets              = module.vpc.private_subnets
      # Openebs Jiva necesita este paquete para funcionar
      additional_userdata = "sudo yum install -y iscsi-initiator-utils"
    },
  ]
  manage_aws_auth                 = true
  cluster_endpoint_public_access  = true
  cluster_endpoint_private_access = true
}
