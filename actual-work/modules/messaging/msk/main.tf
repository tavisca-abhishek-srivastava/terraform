resource "aws_msk_cluster" "tf_s3_to_pg" {
  number_of_broker_nodes = var.number_of_broker_nodes
  cluster_name = var.cluster_name
  kafka_version = var.kafka_version

 broker_node_group_info {
    instance_type = var.instance_type
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
      client_broker = PLAINTEXT
      in_cluster = true
    }
  }
  client_authentication {
    unauthenticated = true
  }


tags = {
"AppName" = "tf_s3_to_pg"
"Backup" = "false"
"BusinessUnit" = "Travel.poc"
"DataClassification" = "internal"
"Environment" = "poc"
"InfraOwner" = "sre-cloud-reliability@tavisca.com"
"Name" = "msk-pg"
"Product" = "poap"
"Squad"  = "Travel.poc"
  
  
  
   
}

}