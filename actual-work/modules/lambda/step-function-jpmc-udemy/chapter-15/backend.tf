terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-step-chapter-15"
    region = "us-east-1"
  }
}