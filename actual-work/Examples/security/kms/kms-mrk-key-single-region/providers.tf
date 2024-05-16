terraform {
   required_providers {
     aws = {
       version = "5.32.0"
     }
   }
 }

 provider "aws" {
   region = var.aws_region
 }

  provider "aws" {
  alias  = "replica"
  region = var.replica_region
}