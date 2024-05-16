terraform {
   required_providers {
     aws = {
       version = "5.32.0"
     }
   }
 }

 provider "aws" {
   region = var.key_primary_region
 }

 provider "aws" {
  region = var.replica_region
  alias  = "replica"
}