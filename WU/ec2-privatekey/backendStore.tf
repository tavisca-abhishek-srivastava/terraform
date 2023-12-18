resource "aws_s3_bucket" "S3_For_RSS" {

bucket = "terrafrom-ec2-privatekey-abhishek"

lifecycle {
            prevent_destroy = true
          }

                                        }