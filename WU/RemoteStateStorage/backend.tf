terraform {
 backend "s3"{
    bucket = "terraform-up-and-running-state-ioc-cloudops"
    key="terraform/remote-backend-example"
    region = "us-east-1"

 }

}