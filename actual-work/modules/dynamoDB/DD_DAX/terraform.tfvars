cluster_name = "nrt-iac-dax"
iam_role_arn = "arn:aws:iam::928814396842:role/service-role/dynamoDBRole"
node_type = "dax.t2.medium"
replication_factor = 3
cluster_endpoint_encryption_type = "TLS"
cluster_description = "DAX" 
parameter_group_name = "default.dax1.0"
security_group_ids =    "sg-0a9f8788cc8e7dbaf"
# subnet_group = "daxsubnetgroup"
subnet_group_details = {
  "name" = "nrt-dax-cluster",
  "subnet_id_1" = "subnet-0140e03481c775864"
  "subnet_id_2" = "subnet-00519af74d280b068"
  "subnet_id_3" = "subnet-001023c820ce7e35c"
}

tags = {
    DataClassification : "restricted"
    Environment : "poc"
    AppName : "tf-nrt-nrt-iac-dax"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tf-nrt-iac-dax"
  
}