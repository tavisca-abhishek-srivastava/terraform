terraform {
  backend "s3" {
    bucket = "poap-iac-terraform-tfstates-poc-appdr-bucket"
    key    = "praveen/networking/vpc/vpc-with-subnets/terraform.tfstate"
    region = "us-east-1"
  }
}