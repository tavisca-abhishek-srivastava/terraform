resource "null_resource" "update_latest_ami" {
    provisioner "local-exec" {
    command = "python3 ./get-latest-ami-put-ssm-parameter.py"
  
  }