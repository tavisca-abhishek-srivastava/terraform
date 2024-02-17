terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-dynamodb-lock"
    region = "us-east-1"
    dynamodb_table = "tsl-pulsar-poc"
  }
}