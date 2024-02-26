resource "aws_appautoscaling_target" "environment_table_by_geo_location_read_target" {
  max_capacity       = 200
  min_capacity       = 50
  for_each = var.gsi_indices
  resource_id        = "table/${aws_dynamodb_table.DD_Table_Provisioned.name}/index/${each.key}"
  scalable_dimension = "dynamodb:index:ReadCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "environment_table_by_geo_location_read_policy" {
  for_each = var.gsi_indices
  name               = "DynamoDBReadCapacityUtilization:${aws_appautoscaling_target.environment_table_by_geo_location_read_target[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.environment_table_by_geo_location_read_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.environment_table_by_geo_location_read_target[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.environment_table_by_geo_location_read_target[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBReadCapacityUtilization"
    }

    target_value = 70.0
  }
}

resource "aws_appautoscaling_target" "environment_table_by_geo_location_write_target" {
  max_capacity       = 300
  min_capacity       = 50
  for_each = var.gsi_indices
  resource_id        = "table/${aws_dynamodb_table.DD_Table_Provisioned.name}/index/${each.key}"
  scalable_dimension = "dynamodb:index:WriteCapacityUnits"
  service_namespace  = "dynamodb"
}

resource "aws_appautoscaling_policy" "environment_table_by_geo_location_write_policy" {
  for_each = var.gsi_indices
  name               = "DynamoDBWriteCapacityUtilization:${aws_appautoscaling_target.environment_table_by_geo_location_write_target[each.key].resource_id}"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.environment_table_by_geo_location_write_target[each.key].resource_id
  scalable_dimension = aws_appautoscaling_target.environment_table_by_geo_location_write_target[each.key].scalable_dimension
  service_namespace  = aws_appautoscaling_target.environment_table_by_geo_location_write_target[each.key].service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "DynamoDBWriteCapacityUtilization"
    }

    target_value = 70.0
  }
}
