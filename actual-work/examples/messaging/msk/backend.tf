terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-kms-s3-to-pg"
    region = "us-east-1"


  }
}