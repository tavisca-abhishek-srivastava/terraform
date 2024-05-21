terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-opensearch-existing-kms"
    region = "us-east-1"
  }
}