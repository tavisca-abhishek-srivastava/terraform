# ...
provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-step-chapter-18"
    region = "us-east-1"
  }
}

resource "aws_sfn_state_machine" "sfn_state_machine_chapter_18" {
  name     = "my-state-machine-ch18"
  role_arn = "arn:aws:iam::928814396842:role/service-role/StepFunctions-MyStateMachine-dxhzah7eh-role-flrrw57f3"
  tags = {
     DataClassification : "internal"
                Environment : "poc"
                AppName : "sf-chp-18"
                InfraOwner : "sre-cloud-reliability@tavisca.com"
                BusinessUnit : "travel.poc"
                Backup : "no"
                Product : "poap"
                Name : "sf-chp-18"
  }

  definition = <<EOF
{
  "Comment": "A description of my state machine",
  "StartAt": "Pass",
  "States": {
    "Pass": {
      "Type": "Pass",
      "InputPath": "$.output",
      "Next": "Wait"
    },
    "Wait": {
      "Type": "Wait",
      "Seconds": 5,
      "End": true
    }
  }
}
 
EOF
}
