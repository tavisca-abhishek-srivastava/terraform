resource "aws_iam_role" "iam-chp-15" {
    name = var.iam_role_name

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

}


data "aws_iam_policy_document" "ec2-policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["ec2:*"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2_access-policy-${var.iam_role_name}"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.ec2-policy_document.json
}

resource "aws_iam_role_policy_attachment" "ec2_test-attach" {
  role       = aws_iam_role.iam-chp-15.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}


data "aws_iam_policy_document" "log_policy_document" {
  statement {
    effect    = "Allow"
    actions   = ["logs:*"]
    resources = ["arn:aws:logs:us-east-1:928814396842:log-group:/aws/lambda/*"]
  }
}

resource "aws_iam_policy" "log_policy" {
  name        = "log_access-policy-${var.iam_role_name}"
  description = "A test policy"
  policy      = data.aws_iam_policy_document.log_policy_document.json
}

resource "aws_iam_role_policy_attachment" "log_test-attach" {
  role       = aws_iam_role.iam-chp-15.name
  policy_arn = aws_iam_policy.log_policy.arn
}

