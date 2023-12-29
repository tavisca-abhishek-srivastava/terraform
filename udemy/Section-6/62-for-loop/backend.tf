terraform {
backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key = "ta/remote-backend-for-ebs"
    region = "us-east-1"


}
}