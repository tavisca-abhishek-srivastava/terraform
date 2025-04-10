module "nrt_msk" {
  source = "../../../modules/messaging/msk"
  cluster_name = var.cluster_name
  client_subnets = var.client_subnets
  kafka_version = var.kafka_version
  cloud_watch_log_group_retention_days = var.cloud_watch_log_group_retention_days
  encryption_in_transit_client_broker = var.encryption_in_transit_client_broker
  delete_after_days = var.delete_after_days
  instance_type =var.instance_type
  security_groups = var.security_groups
  number_of_broker_nodes = var.number_of_broker_nodes
  tags = var.tags
}

output "msk_broker_list" {
  value = module.nrt_msk.msk_broker_list
}

output "msk_zookeeper_list" {
  value = module.nrt_msk.msk_zookeeper_list
}