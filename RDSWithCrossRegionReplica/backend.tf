terraform {
backend "s3" {
    bucket = "terrafrom-ec2-privatekey-abhishek"
    key = "terraform/remote-backend-rds-with-cross-region-replication"
    region = "us-east-1"
}


}