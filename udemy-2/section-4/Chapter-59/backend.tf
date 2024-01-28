terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-lifecycle-management"
    region = "us-east-1"


  }
}