terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-nrt-ecs_task_definition"
    region = "us-east-1"
  }
}