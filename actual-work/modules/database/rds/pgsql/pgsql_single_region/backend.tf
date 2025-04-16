terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-aurora-pg"
    region = "us-east-1"


  }
}