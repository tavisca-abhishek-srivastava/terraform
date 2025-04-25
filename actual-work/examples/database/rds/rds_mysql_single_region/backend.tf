terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-rds-mysql-ro"
    region = "us-east-1"
  }
}