resource "aws_appautoscaling_target" "aurora_read_replica_target" {
  service_namespace  = "rds"
  resource_id        = "cluster:${aws_rds_cluster.postgresql.id}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  min_capacity       = 2
  max_capacity       = 3
}

resource "aws_appautoscaling_policy" "aurora_read_replica_policy" {
  name               = "aurora-read-replica-scaling-policy"
  service_namespace  = "rds"
  resource_id        = "cluster:${aws_rds_cluster.postgresql.id}"
  scalable_dimension = "rds:cluster:ReadReplicaCount"
  policy_type        = "TargetTrackingScaling"

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "RDSReaderAverageCPUUtilization"
    }
    target_value = 20.0 // Target 50% average CPU utilization
    scale_in_cooldown  = 300 // Seconds
    scale_out_cooldown = 300 // Seconds
  }
}