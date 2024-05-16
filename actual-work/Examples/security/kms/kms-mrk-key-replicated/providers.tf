terraform {
   required_providers {
     aws = {
       version = "5.32.0"
     }
   }
 }

 provider "aws" {
   region = var.aws_region
   alias = "primary"
 }

 provider "aws" {
  region = var.replica_region
  alias  = "replica"
}