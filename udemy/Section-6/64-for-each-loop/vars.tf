variable "aws_region" {
    type = string
    default = "us-east-1"
  
}

variable "ingress_ports_tcp" {
    type = map(list(string))
  default = {
    "8091" = [ "10.1.2.0/24","10.2.2.0/24" ]
    "22" = ["10.0.0.0/8"]
  }
}
variable "ingress_ports_udp" {
    type = map(list(string))
  default = {
    "8092" = [ "10.1.2.0/24","10.2.2.0/24" ]
    "23" = ["10.0.0.0/8"]
  }
}

variable "egress_ports" {
    type = map(list(string))
  default = {
    "0" = [ "0.0.0.0/0" ]
  }
}
variable "vpc_id" {
   default = "vpc-07b12bcec12a4cd9b"
}