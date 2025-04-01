terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-kms-mrk-single-region-json"
    region = "us-east-1"
  }
}