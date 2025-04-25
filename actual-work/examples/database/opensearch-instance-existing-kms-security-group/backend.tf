terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-opensearch-existing-kms-2"
    region = "us-east-1"
  }
}