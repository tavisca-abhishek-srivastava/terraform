terraform {
  required_providers {
     aws = {
      source = "hashicorp/aws"
       version = "5.32.0"
     }
  }
  cloud {
    organization = "cxloyalty"
    workspaces {
      name = "TaviscaChaseTravel1"
    }
  }
 }

 provider "aws" {
   region = var.aws_region
 }