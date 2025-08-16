output "name_of_primary_subnet" {
  value = module.nrt_rds_subnet_group.primary_region_subnet_name
}

output "name_of_replica_subnet" {
  value = module.nrt_rds_subnet_group_or.primary_region_subnet_name
}