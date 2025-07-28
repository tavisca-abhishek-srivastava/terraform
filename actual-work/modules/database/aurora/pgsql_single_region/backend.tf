terraform {
  backend "s3" {
    bucket = "bnr-bucket-poc"
    key    = "ta/remote-backend-aurora-pg"
    region = "us-east-1"


  }
}