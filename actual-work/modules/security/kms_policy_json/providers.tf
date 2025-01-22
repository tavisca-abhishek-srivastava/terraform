terraform {
   required_providers {
     aws = {
       version = "5.80.0"
     }
   }
 }

 provider "aws" {
   region = var.key_primary_region
   alias = "primary"
 }

# provider "aws" {
#       alias = "instancemaker"
# }