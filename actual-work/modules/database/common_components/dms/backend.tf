terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-dms-subnet-group"
    region = "us-east-1"


  }
}