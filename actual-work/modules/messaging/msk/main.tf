data "aws_caller_identity" "current" {}

module "msk_encryption_at_rest_cmk" {
  	source            = "../../security/kms_policy_json"
  	kms_alias         = "alias/${var.cluster_name}_key"
    delete_after_days = var.delete_after_days
  	key_description   =  "Key for ${var.cluster_name} KMS Cluster "
  	key_policy_map = var.key_policy_map
	kms_tags = var.tags  
}

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
    #encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:928814396842:key/0812992e-897f-41cc-b4e2-e1a2d1b3b672"
    encryption_at_rest_kms_key_arn = module.msk_encryption_at_rest_cmk.mrk_cms_arn
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