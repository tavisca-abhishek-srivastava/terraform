terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-opensearch-based-es-example"
    region = "us-east-1"
  }
}