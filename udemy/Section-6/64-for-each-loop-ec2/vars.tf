variable "aws_region" {
    type = string
    default = "us-east-1"
}

locals {
  time = formatdate("DD-MM-YYYY  hh:mm ZZZ", timestamp())
}

variable "keyName" {
   default = "mykey_test_fe_ec2"
}
variable "privatekeyPath" {
   default = "/home/ec2-user/terraform/keys/mykey_test_fe_ec2.pem"
  #  ssh-keygen -f  mykey_test_fe_ec2
  #  mv mykey_test_fe_ec2 mykey_test_fe_ec2.pem
}
variable "publickeyName" {
   default = "mykey_test_fe_ec2.pub"
}
# variable "publickeyPath" {
#   #  default = "/home/ec2-user/terraform/keys/mykey_test_fe_ec2.pub"
#   default = "/home/ec2-user/terraform/keys/${var.publickeyName}"
# }
locals {
 publickeyPath =  "/home/ec2-user/terraform/keys/${var.publickeyName}"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "name_security_groups" {
   default = "cb-citrix-sg"
}
variable "sg_ingress_rules" {
    type = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = {
        rule1 =       {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "SSH"
        },

        rule2 =         {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "HTTP"
        },
        rule3 =        {
          from_port   = 1494
          to_port     = 1494
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "Citrix"
        },
        rule4 =        {
          from_port   = 18091
          to_port     = 18091
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "Couchbase"
        },
    }
}
variable "sg_egress_rules" {
    type = map(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
        }))
    default     = {
        rule1 = {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_block  = "0.0.0.0/0"
         },
        
          }
}

variable "ec2_conf" {
  type = map(object({
      vm_size   = string
      zone     = string
      subnet    = string
     
        }))
  default = {
            "vm1" = { vm_size = "e2-small", zone = "us-east-1a",subnet = "subnet-04c8a1cce0a80f526" },
 
            "vm2" = { vm_size = "e2-medium", zone = "us-east-1b" ,subnet = "subnet-08792a1a703950fe7"},
 
            "vm4" = { vm_size = "f1-micro", zone = "us-east-1c" ,subnet = "subnet-001023c820ce7e35c"},
  }
}


variable "vpc_id" {
   default = "vpc-07b12bcec12a4cd9b"
}

output "private_ip" {
value = aws_instance.example1
sensitive = true
description = "The private IP address of the web server"
 }
