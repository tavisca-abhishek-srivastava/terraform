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
              "url": "https://github.com/tavisca-abhishek-srivastava/terraform/tree/main/udemy/Section-6/62-for-loop"

    }
  
}
output "arn" {
    value = "${aws_ebs_volume.ebs_test_for_loop.volume_id}"
    description = "The private IP address of the web server"
}