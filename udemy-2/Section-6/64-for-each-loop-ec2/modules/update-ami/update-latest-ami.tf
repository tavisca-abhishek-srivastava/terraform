terraform {
  required_providers {
    aws = {
      version = "5.33.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "null_resource" "update_latest_ami" {
    provisioner "local-exec" {
    command = "python3 ./get-latest-ami-put-ssm-parameter.py"
  
  }
}