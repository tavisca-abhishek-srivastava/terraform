terraform {
   required_providers {
     aws = {
       version = "5.32.0"
     }
   }
 }

 provider "aws" {
   region = "us-east-1"
 }