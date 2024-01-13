terraform {
backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key = "ta/remote-backend-git-repo-tf"
    region = "us-east-1"


}
}