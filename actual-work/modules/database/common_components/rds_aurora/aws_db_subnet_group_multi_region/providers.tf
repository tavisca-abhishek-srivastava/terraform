provider "aws" {
│       source = "hashicorp/aws"
│       configuration_aliases = [ aws.instancemaker, ]
│     }