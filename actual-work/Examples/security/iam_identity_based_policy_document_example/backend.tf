terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-iam-identity-based-policy-document"
    region = "us-east-1"
  } 
}