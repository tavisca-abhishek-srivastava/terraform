resource "aws_msk_cluster" "tf_s3_to_pg" {
  number_of_broker_nodes = 3
  cluster_name = tf_s3_to_pg
  kafka_version = 3.6

 broker_node_group_info {
    instance_type = "kafka.m5.large"
    client_subnets = [
        "subnet-060048463710e54c4",
        "subnet-01d4d19deaa34db85",
        "subnet-061e332b24aecd27b",
    ]
    storage_info {
      ebs_storage_info {
        volume_size = 30
      }
    }
    security_groups = ["sg-07c3c80e71d4b954e"]
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = "arn:aws:kms:us-east-1:928814396842:key/0812992e-897f-41cc-b4e2-e1a2d1b3b672"
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