resource "aws_s3_bucket" "S3_For_RSS_feed" {
bucket = "tapoc-ec2-privatekey-1"
tags = {
            DataClassification: "restricted"
            Environment: "poc"
            AppName:  "as-testing-client-1-s33"
            InfraOwner: "sre-cloud-reliability@tavisca.com"
            BusinessUnit: "travel.app"
            Backup: "no"
            Product: "poap"
            Name: "as-testing-client-1-s3"
  }
 }