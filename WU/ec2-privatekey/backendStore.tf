resource "aws_s3_bucket" "S3_For_RSS" {

bucket = "tapoc-ec2-privatekey"

lifecycle {
            prevent_destroy = true
          }

                                        }