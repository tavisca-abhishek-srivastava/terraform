provider "aws" {
  region = "us-east-1"
}

data "archive_file" "dummy" {
  type = "zip"
  output_path = "${path.module}/lambda_function_payload.zip"
  source {
    content = file("./addAuthorLambda.js")
    filename = "addAuthorLambda.js"
  }
  
}




resource "aws_lambda_function" "lambda-chp-15" {
    function_name = "AddAuthor"
    filename = "${data.archive_file.dummy.output_path}"
    role = aws_iam_role.iam-chp-15.arn
    runtime = "nodejs16.x"
    handler =  "index.handler"
    vpc_config {
      subnet_ids = [ "subnet-04c8a1cce0a80f526" ]
      security_group_ids = [ "sg-002ed7ae59485b4d2" ]
    }
    tags = {
                DataClassification : "internal"
                Environment : "poc"
                AppName : "lambda-chp-15"
                InfraOwner : "sre-cloud-reliability@tavisca.com"
                BusinessUnit : "travel.poc"
                Backup : "no"
                Product : "poap"
                Name : "lambda-chp-15"
}
}