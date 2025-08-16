terraform {
  backend "s3" {
    bucket = "bnr-bucket-poc"
    key    = "ta/remote-backend-subnet_group_mr"
    region = "us-east-1"


  }
}