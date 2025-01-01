terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-kms-mrk-single-region_json"
    region = "us-east-1"
  }
}