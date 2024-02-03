terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-error-management"
    region = "us-east-1"


  }
}