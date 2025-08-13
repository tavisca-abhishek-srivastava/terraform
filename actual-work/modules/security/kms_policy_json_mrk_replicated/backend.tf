terraform {
  backend "s3" {
    bucket = "bnr-bucket-poc"
    key    = "ta/remote-backend-nrt_mrk"
    region = "us-east-1"


  }
}