terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-dynamodb-no-gsi"
    region = "us-east-1"


  }
}