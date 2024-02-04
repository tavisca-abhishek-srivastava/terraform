terraform {
  required_providers {
    aws = {
      version = "5.32.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "mykey" {
  key_name   = "${var.keyName}"
  public_key = file(local.publickeyPath)
}

resource "null_resource" "update_latest_ami" {
    provisioner "local-exec" {
    command = "python3 ./get-latest-ami-put-ssm-parameter.py"
  
  }
  
}

data "aws_ssm_parameter" "latest_linux_ami" {
  depends_on = [ null_resource.update_latest_ami ]
  name = "tapoc-latest-ami" #https://stackoverflow.com/questions/57776524/terraform-get-a-value-from-parameter-store-and-pass-to-resource
}


resource "aws_instance" "example1" {

  depends_on = [ data.aws_ssm_parameter.latest_linux_ami, null_resource.update_latest_ami ]
  
  for_each = var.ec2_conf

  ami                    = data.aws_ssm_parameter.latest_linux_ami.value
  availability_zone      = "${each.value.zone}"
  instance_type          = local.instance_type
  key_name               = "${var.keyName}"
  vpc_security_group_ids = [aws_security_group.ec2_security_groups_for_each.id]
  subnet_id              = each.value.subnet
  iam_instance_profile   = "tf-role-testing"
  root_block_device {
    volume_size           = 50
    volume_type           = "gp3"
    delete_on_termination = true
  }
  volume_tags = {
    DataClassification : "restricted"
    Environment : "poc"
    AppName : "tapoc-testing-client-${each.value.zone}-ebs"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tapoc-testing-client--${each.value.zone}-ebs"
  }
  tags = {
    DataClassification : "restricted"
    Environment : "poc"
    AppName : "tapoc-testing-client-${each.value.zone}"
    InfraOwner : "sre-cloud-reliability@tavisca.com"
    BusinessUnit : "travel.app"
    Backup : "no"
    Product : "poap"
    Name : "tapoc-testing-client-${each.value.zone}"
    TimeOfCreation : local.time
  }

  provisioner "file" {
    source      = "install-nginx.sh"
    destination = "/tmp/install-nginx.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/install-nginx.sh",
      "sudo sh /tmp/install-nginx.sh",
    ]
  }



  connection {
    type        = "ssh"
    user        = "ec2-user"
    password    = ""
    private_key = file(var.privatekeyPath)
    host        = self.private_ip
  }
}