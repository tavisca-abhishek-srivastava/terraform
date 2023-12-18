terraform {
backend "s3" {
    bucket = "terrafrom-ec2-privatekey-abhishek"
    key = "terraform/remote-backend-ec2-privatekey"
    region = "us-east-1"


}
}