terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-kms-mrk"
    region = "us-east-1"
  } 
}