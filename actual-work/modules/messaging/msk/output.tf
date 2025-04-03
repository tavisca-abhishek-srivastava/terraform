output "msk_broker_list" {
  value = aws_msk_cluster.tf-s3-to-pg.bootstrap_brokers
}

output "msk_zookeeper_list" {
  value = aws_msk_cluster.tf-s3-to-pg.zookeeper_connect_string
}