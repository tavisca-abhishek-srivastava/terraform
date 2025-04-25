terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-dynamodb-dest-stream-enabled"
    region = "us-east-1"


  }
}