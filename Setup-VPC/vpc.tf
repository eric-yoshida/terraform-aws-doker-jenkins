module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc-name
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.11.0/24", "10.0.21.0/24", "10.0.31.0/24"]
  public_subnets  = ["10.0.10.0/24", "10.0.20.0/24", "10.0.30.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = false
  one_nat_gateway_per_az = false


  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}