data "aws_vpc" "selected" {
  filter {
    name = "tag:Name"
    values = ["my-vpc"]
  }
}

##Selecao de uma subnet para criacao de instancia
# data "aws_subnet" "selected" {
#   filter {
#     name   = "tag:Name"
#     values = ["my-vpc-private-us-east-1a"]
#   }
# }

#Selecao de multiplas subnets para criacao de instancia
data "aws_subnet_ids" "public" {
  vpc_id = data.aws_vpc.selected.id
  
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }
}


module "meu_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "EC2-SG-HTTP"
  description = "SG for EC2 Instance with 80 port allowed."
  vpc_id      = data.aws_vpc.selected.id
  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_rules            = ["http-80-tcp", "ssh-tcp", "http-8080-tcp"]
  egress_rules             = ["all-all"]
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"
  name = "minha-ec2"
  for_each      = data.aws_subnet_ids.public.ids
  ami                    = "ami-087c17d1fe0178315"
  instance_type          = "t2.micro"
  key_name               = "vockey" 
  monitoring             = true
  vpc_security_group_ids = [module.meu_sg.security_group_id]
  #subnet_id              = data.aws_subnet.selected.id
  subnet_id     = each.value
  user_data = file("./install_dependencies.sh")
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

