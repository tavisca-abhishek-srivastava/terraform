provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
        version = "5.30.0"
          }
                     }

          }

resource "aws_key_pair" mykey {
    key_name = "mykey_test"
    public_key = "${file("${var.publickeyPath}")}"
}

data "aws_ssm_parameter" "instance_type_citrix" {
  name = "pocInstanceType"
}

data "aws_ssm_parameter" "latest_linux_ami" {
  name = "tapoc-latest-ami"    #https://stackoverflow.com/questions/57776524/terraform-get-a-value-from-parameter-store-and-pass-to-resource
}


resource "aws_instance" "example1" {

      for_each = {
 
            "vm1" = { vm_size = "e2-small", zone = "us-east-1a",subnet = "subnet-04c8a1cce0a80f526" }
 
            "vm2" = { vm_size = "e2-medium", zone = "us-east-1b" ,subnet = "subnet-08792a1a703950fe7"}
 
            "vm3" = { vm_size = "f1-micro", zone = "us-east-1c" ,subnet = "subnet-001023c820ce7e35c"}
 
                }


        ami = data.aws_ssm_parameter.latest_linux_ami.value
        availability_zone = each.value.zone
        instance_type = data.aws_ssm_parameter.instance_type_citrix.value
        key_name = "${var.keyName}"
        vpc_security_group_ids =  [aws_security_group.ec2_security_groups_for_each.id]
        subnet_id = each.value.subnet
        iam_instance_profile = "tf-role-testing"
        root_block_device {
          volume_size = 50
          volume_type = "gp3"
          delete_on_termination = true
        }
        volume_tags = {
              DataClassification: "restricted"
              Environment: "poc"
              AppName:  "tapoc-testing-client--${each.value.zone}-ebs"
              InfraOwner: "sre-cloud-reliability@tavisca.com"
              BusinessUnit: "travel.app"
              Backup: "no"
              Product: "poap"
              Name: "tapoc-testing-client--${each.value.zone}-ebs"
               }
        tags = {
              DataClassification: "restricted"
              Environment: "poc"
              AppName:  "tapoc-testing-client-${each.value.zone}"
              InfraOwner: "sre-cloud-reliability@tavisca.com"
              BusinessUnit: "travel.app"
              Backup: "no"
              Product: "poap"
              Name: "tapoc-testing-client-${each.value.zone}"
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