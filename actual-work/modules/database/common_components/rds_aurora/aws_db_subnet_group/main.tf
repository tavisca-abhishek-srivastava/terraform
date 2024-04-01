## added provider here to create resources in dr region as well
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_db_subnet_group" "subnet_group_for_db" {
  name = var.subnet_group_name
  subnet_ids = var.subnet_ids
  tags = var.tags

}

