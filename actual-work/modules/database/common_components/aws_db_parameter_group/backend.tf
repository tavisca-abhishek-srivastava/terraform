terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-rds-parameter-group"
    region = "us-east-1"
  }
}