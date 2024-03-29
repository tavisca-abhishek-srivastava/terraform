terraform {
   required_providers {
     aws = {
       version = "5.32.0"
     }
   }
 }

 provider "aws" {
   region = var.aws_region
   alias = "default"
 }

provider "aws" {
region= var.region_for_cross_region_read_replica
alias = "dr"
}