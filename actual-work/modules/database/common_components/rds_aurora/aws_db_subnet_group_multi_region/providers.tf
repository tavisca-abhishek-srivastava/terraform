terraform {
   required_providers {
     aws = {
      source = "hashicorp/aws"
       version = "5.80.0"
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