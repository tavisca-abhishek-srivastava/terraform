resource "aws_s3_bucket" "S3_For_RSS" {

bucket = "tapoc-ec2-privatekey-1"

lifecycle {
            prevent_destroy = true
          }

                                        }