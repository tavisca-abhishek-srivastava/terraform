variable "aws_region" {
    type = string
  default = "us-east-1"
}

variable "project_tags" {
    type = map(string)
    default = {
              "DataClassification" = "restricted"
              "Environment": "poc"
              "AppName":  "tapoc-ebs_test_for_loop"
              "InfraOwner": "sre-cloud-reliability@tavisca.com"
              "BusinessUnit": "travel.app"
              "Backup": "no"
              "Product": "poap"

    }
  
}