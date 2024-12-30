# ...
provider "aws" {
  region = "us-east-1"
}
terraform {
  backend "s3" {
    bucket = "tapoc-ec2-privatekey"
    key    = "ta/remote-backend-step-chapter-17"
    region = "us-east-1"
  }
}

resource "aws_sfn_state_machine" "sfn_state_machine" {
  name     = "my-state-machine-ch17"
  role_arn = "arn:aws:iam::928814396842:role/service-role/StepFunctions-MyStateMachine-dxhzah7eh-role-flrrw57f3"
  tags = {
     DataClassification : "internal"
                Environment : "poc"
                AppName : "sf-chp-17"
                InfraOwner : "sre-cloud-reliability@tavisca.com"
                BusinessUnit : "travel.poc"
                Backup : "no"
                Product : "poap"
                Name : "sf-chp-17"
  }

  definition = <<EOF

 {
  "Comment": "A description of my state machine",
  "StartAt": "WaitABit",
  "States": {
    "WaitABit": {
      "Type": "Wait",
      "Seconds": 5,
      "Next": "Lambda Invoke"
    },
    "Lambda Invoke": {
      "Type": "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "OutputPath": "$.Payload",
      "Parameters": {
        "Payload.$": "$",
        "FunctionName": "arn:aws:lambda:us-east-1:928814396842:function:mystepfun_lambda:$LATEST"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2
        }
      ],
      "Next": "Pass"
    },
    "Pass": {
      "Type": "Pass",
      "Next": "Wait"
    },
    "Wait": {
      "Type": "Wait",
      "Seconds": 5,
      "Next": "AddAuthor"
    },
    "AddAuthor": {
      "Type": "Task",
      "Resource": "arn:aws:states:::lambda:invoke",
      "OutputPath": "$.Payload",
      "Parameters": {
        "Payload.$": "$",
        "FunctionName": "arn:aws:lambda:us-east-1:928814396842:function:AddAuthor:$LATEST"
      },
      "Retry": [
        {
          "ErrorEquals": [
            "Lambda.ServiceException",
            "Lambda.AWSLambdaException",
            "Lambda.SdkClientException",
            "Lambda.TooManyRequestsException"
          ],
          "IntervalSeconds": 1,
          "MaxAttempts": 3,
          "BackoffRate": 2
        }
      ],
      "End": true
    }
  }
}

EOF
}
