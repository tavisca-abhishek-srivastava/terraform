terraform {
  backend "s3" {
    bucket = "bnr-bucket-poc"
    key    = "ta/remote-backend-aurora-mysql"
    region = "us-east-1"


  }
}