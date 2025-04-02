resource "aws_msk_cluster" "tf-s3-to-pg" {
  number_of_broker_nodes = var.number_of_broker_nodes
  cluster_name           = var.cluster_name
  kafka_version          = var.kafka_version

  broker_node_group_info {
    instance_type  = var.instance_type
    client_subnets = var.client_subnets
    storage_info {
      ebs_storage_info {
        volume_size = 30
      }
    }
    security_groups = var.security_groups
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:928814396842:key/0812992e-897f-41cc-b4e2-e1a2d1b3b672"
    encryption_in_transit {
      client_broker = var.encryption_in_transit_client_broker
      in_cluster    = true
    }
  }
  client_authentication {
    unauthenticated = true
  }
    logging_info {
      broker_logs {
        cloudwatch_logs {
          enabled = true
          log_group = aws_cloudwatch_log_group.kms_log_group.name
        }
      }
    }

  tags = var.tags

}