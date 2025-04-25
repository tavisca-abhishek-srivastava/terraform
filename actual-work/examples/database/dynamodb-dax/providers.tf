terraform {
   required_providers {
     aws = {
       version = "5.80.0"
     }
   }
 }

 provider "aws" {
   region = var.aws_region
 }