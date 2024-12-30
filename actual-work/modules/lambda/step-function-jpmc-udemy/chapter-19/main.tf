# ...
provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-step-chapter-19"
    region = "us-east-1"
  }
}

resource "aws_sfn_state_machine" "sfn_state_machine_chapter_19" {
  name     = "my-state-machine-ch19"
  role_arn = "arn:aws:iam::928814396842:role/service-role/StepFunctions-MyStateMachine-dxhzah7eh-role-flrrw57f3"
  tags = {
     DataClassification : "internal"
                Environment : "poc"
                AppName : "sf-chp-19"
                InfraOwner : "sre-cloud-reliability@tavisca.com"
                BusinessUnit : "travel.poc"
                Backup : "no"
                Product : "poap"
                Name : "sf-chp-19"
  }

  definition = <<EOF
{
  "Comment": "A description of my state machine",
  "StartAt": "input",
  "States": {
    "input": {
      "Type": "Pass",
      "Parameters": {
            "About":  "Pulling data that I want",
            "Info": {
                    "status.$": "$.output.lambdaResult.Payload.statusCode",
                    "body.$": "$.output.lambdaResult.Payload.body"
            }
      
      },
      "Next": "Wait"
    },
    "Wait": {
      "Type": "Wait",
      "InputPath":  "$.Info",
      "Seconds": 5,
      "End": true
    }
  }
}
 
EOF
}
