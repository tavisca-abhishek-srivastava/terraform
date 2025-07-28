terraform {
  backend "s3" {
    bucket = "bnr-cassandra-dataapi-poc-922451091924"
    key    = "ta/remote-backend-aurora-pg"
    region = "us-east-1"


  }
}