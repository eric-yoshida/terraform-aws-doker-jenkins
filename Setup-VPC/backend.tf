terraform {
  backend "s3" {
    bucket = "your-bucket"
    key    = "remotedemo.tfstate"
    region     = "us-east-1"
  }
}
