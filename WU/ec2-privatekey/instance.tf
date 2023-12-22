provider "aws" {
region="us-east-1"
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

resource "aws_ebs_volume" "ebs-volume-1" {
  
  availability_zone = "us-east-1a"
  size = 20
  type = "io2"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ebs-volume-1.id}"
  instance_id = "${aws_instance.example1.id}"
}



resource "aws_instance" "example1" {
        ami = data.aws_ssm_parameter.latest_linux_ami.value
        availability_zone = "us-east-1a"
        instance_type = data.aws_ssm_parameter.instance_type_citrix.value
        key_name = "${var.keyName}"
        vpc_security_group_ids =  [aws_security_group.ec2_security_groups.id]
        subnet_id = "subnet-04c8a1cce0a80f526"
        iam_instance_profile = "tf-role-testing"
        root_block_device {
          volume_size = 50
          volume_type = gp3
          delete_on_termination = true
        }
        volume_tags = {
              DataClassification: "restricted"
              Environment: "poc"
              AppName:  "tapoc-testing-client-1-ebs"
              InfraOwner: "sre-cloud-reliability@tavisca.com"
              BusinessUnit: "travel.app"
              Backup: "no"
              Product: "poap"
              Name: "tapoc-testing-client-1-ebs"
               }
        tags = {
              DataClassification: "restricted"
              Environment: "poc"
              AppName:  "as-testing-client-1"
              InfraOwner: "sre-cloud-reliability@tavisca.com"
              BusinessUnit: "travel.app"
              Backup: "no"
              Product: "poap"
              Name: "as-testing-client-1"
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

resource "time_sleep" "wait_for_server" {
  create_duration = "300s"

  depends_on = [aws_instance.example1]
}