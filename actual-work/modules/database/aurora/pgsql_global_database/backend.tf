terraform {
  backend "s3" {
    bucket = "bnr-bucket-poc"
    key    = "ta/remote-backend-aurora-pg_gc"
    region = "us-east-1"


  }
}