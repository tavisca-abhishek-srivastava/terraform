terraform {
   required_providers {
     aws = {
      source = "hashicorp/aws"
       version = "5.32.0"
     }
   }
   cloud {
    organization = "my-org"
    hostname = "app.terraform.io" # Optional; defaults to app.terraform.io
    workspaces {
      project = "networking-development"
      tags = ["networking", "source:cli"]
    }
  }
 }

 provider "aws" {
   region = var.aws_region
 }