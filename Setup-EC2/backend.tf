terraform {
  backend "s3" {
    bucket = "your-bucket"
    key    = "ec2-remotedemo.tfstate"
    region     = "us-east-1"
   # dynamodb_table = "s3-state-lock"
  }
}
