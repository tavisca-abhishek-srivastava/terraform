provider "aws" {
  region = var.aws_region
  
}
terraform {
  required_providers {
    aws = {
        version = "5.30.0"

    }
  }

}

resource "aws_security_group" "my_sg_for_each_loop_sf" {
  name = "tapoc-sg_test_for_loop"
  vpc_id = var.vpc_id
   dynamic "ingress" {
    for_each = var.ingress_ports_tcp
    content {
        from_port = ingress.key
        to_port = ingress.key
        cidr_blocks = ingress.value
        protocol = "tcp"
    }

  }
    dynamic "ingress" {
      for_each = var.ingress_ports_udp
      content {
        from_port = ingress.key
        to_port = ingress.key
        cidr_blocks = ingress.value
        protocol = "udp"
    }

  }

  tags = {
              "DataClassification" : "restricted"
              "Environment": "poc"
              "AppName":  "tapoc-sg_test_foreach_loop"
              "Name":  "tapoc-sg_test_foreach_loop"
              "InfraOwner": "sre-cloud-reliability@tavisca.com"
              "BusinessUnit": "travel.app"
              "Backup": "no"
              "Product": "poap"
              "url": "https://github.com/tavisca-abhishek-srivastava/terraform/tree/main/udemy/Section-6/64-for-each-loop"
  }
}