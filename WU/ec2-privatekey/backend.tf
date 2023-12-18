terraform {
backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key = "ta/remote-backend-ec2-privatekey"
    region = "us-east-1"


}
}