terraform {
  backend "s3" {
    bucket = "dynamodb-export-to-s3-us-east-1-346319152574"
    key    = "ta/remote-backend-nrt-ecr_service"
    region = "us-east-1"
  }
}