provider  aws {
     
      region = "us-east-1"
}


resource "aws_s3_bucket" "S3_For_RSS"{
    bucket = "terraform-up-and-running-state-ioc-cloudops"
    
                }
    lifecycle {
        prevent_destroy = true
              }
}