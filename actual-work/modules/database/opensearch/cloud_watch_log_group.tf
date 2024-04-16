resource "aws_cloudwatch_log_group" "opensearch_log_group_index_slow_logs" {
  name              = "/aws/opensearch/${var.open_search_domain_name}/index-slow"
  retention_in_days = 14
}


resource "aws_cloudwatch_log_group" "opensearch_log_group_search_slow_logs" {
  name              = "/aws/opensearch/${var.open_search_domain_name}/search-slow"
  retention_in_days = 14
}


resource "aws_cloudwatch_log_group" "opensearch_log_group_es_application_logs" {
  name              = "/aws/opensearch/${var.open_search_domain_name}/es-application"
  retention_in_days = 14
}


resource "aws_cloudwatch_log_resource_policy" "opensearch_log_resource_policy" {
  policy_name = "${var.open_search_domain_name}-domain-log-resource-policy"

  policy_document = <<CONFIG
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "es.amazonaws.com"
      },
      "Action": [
        "logs:PutLogEvents",
        "logs:PutLogEventsBatch",
        "logs:CreateLogStream"
      ],
      "Resource": [
        "${aws_cloudwatch_log_group.opensearch_log_group_index_slow_logs.arn}:*",
        "${aws_cloudwatch_log_group.opensearch_log_group_search_slow_logs.arn}:*",
        "${aws_cloudwatch_log_group.opensearch_log_group_es_application_logs.arn}:*"
      ],
      "Condition": {
          "StringEquals": {
              "aws:SourceAccount": "${data.aws_caller_identity.current.account_id}"
          },
          "ArnLike": {
              "aws:SourceArn": "arn:aws:es:eu-central-1:${data.aws_caller_identity.current.account_id}:domain/${var.open_search_domain_name}"
          }
      }
    }
  ]
}
CONFIG
}