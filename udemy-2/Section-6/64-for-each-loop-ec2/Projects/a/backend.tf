terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-module-nrt-multiple-ec2"
    region = "us-east-1"


  }
}