terraform {
  backend "s3" {
    bucket = "eric-terraform-jenkins"
    key    = "remotedemo.tfstate"
    region     = "us-east-1"
  }
}
