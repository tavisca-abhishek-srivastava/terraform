terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-ecr_multicontainer"
    region = "us-east-1"
  }
}