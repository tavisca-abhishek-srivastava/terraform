locals {
  tls_security_policy = "Policy-Min-TLS-1-2-2019-07"
  node_to_node_encryption_enabled = true
  log_publishing_options_enabled = true
  
}
locals {
  anonymous_auth_enabled = false
}
locals {
  terrform_operation_timeout = "360m"
}