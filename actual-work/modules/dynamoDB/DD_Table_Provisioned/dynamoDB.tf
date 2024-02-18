
#--------------------------------------------------------------------------------#
#                                                                                #
#                                                                                #
#--------------------------------------------------------------------------------#

resource "aws_dynamodb_table" "ddtable_DD_PAY_PER_REQUEST" {
  name = "${var.aws_dynamodb_table_name}"
  billing_mode   = "PROVISIONED"
  hash_key = var.table_hash_key
  range_key = var.table_range_key
  deletion_protection_enabled = var.enable_deletion_protection
  point_in_time_recovery {
    enabled = true
  }
  server_side_encryption {
    enabled = true   # true -> "Managed by customer" , false -> "Managed by DynamoDB "
    kms_key_arn = var.kms_key_arn
  }
  
   dynamic "global_secondary_index" {
   for_each = var.gsi_indices
    content {
      name            = global_secondary_index.key
      write_capacity  = global_secondary_index.value.write_capacity
      read_capacity   = global_secondary_index.value.read_capacity
      range_key       = global_secondary_index.value.range_key
      hash_key        = global_secondary_index.key
      projection_type = "ALL"
    }
  }
  dynamic "local_secondary_index" {
    for_each = var.lsi_indices
    content {
    name = local_secondary_index.key
    range_key = local_secondary_index.value.range_key
    projection_type = "ALL"
  }
  }
   dynamic "attribute" {
    for_each = var.attributes
    content {
      name = attribute.value.name
      type = attribute.value.type
    }
   }

  tags =   {
    DataClassification : "restricted"
    Environment : "poc"
    AppName : "tf-nrt-${var.aws_dynamodb_table_name}"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tf-${var.aws_dynamodb_table_name}"
  }
}


resource "aws_appautoscaling_target" "environment_table_read_target" {
  max_capacity       = 20
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.ddtable_DD_PAY_PER_REQUEST.name}"
  scalable_dimension = "dynamodb:table:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "environment_table_read_policy" {
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.environment_table_read_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.environment_table_read_target.resource_id
  scalable_dimension = aws_appautoscaling_target.environment_table_read_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.environment_table_read_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = 70.0
  }
}

resource "aws_appautoscaling_target" "environment_table_write_target" {
  max_capacity       = 10
  min_capacity       = 5
  resource_id        = "table/${aws_dynamodb_table.ddtable_DD_PAY_PER_REQUEST.name}"
  scalable_dimension = "dynamodb:table:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "environment_table_write_policy" {
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.environment_table_write_target.resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.environment_table_write_target.resource_id
  scalable_dimension = aws_appautoscaling_target.environment_table_write_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.environment_table_write_target.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = 70.0
  }
}
