terraform {
backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key = "ta/remote-backend-foreach-sg"
    region = "us-east-1"


}
}