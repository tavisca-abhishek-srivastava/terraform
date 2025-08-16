terraform {
   required_providers {
     aws = {
      source = "hashicorp/aws"
       version = "5.82.2"
     }
   }
 }

 provider "aws" {
   region = var.primary_region
   alias = "primary"
 }

 provider "aws" {
  region = var.replica_region
  alias  = "replica"
}

# provider "aws" {
#       alias = "instancemaker"
# }