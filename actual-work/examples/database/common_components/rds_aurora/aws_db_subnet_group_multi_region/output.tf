output "name_of_primary_subnet" {
  value = module.nrt_rds_subnet_group["1"].subnet_name.name_of_primary_subnet
}

output "name_of_replica_subnet" {
  value = module.nrt_rds_subnet_group_or["1"].subnet_name.name_of_primary_subnet
}