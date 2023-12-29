variable "aws_region" {
    type = string
    default = "us-east-1"
  
}

variable "ingress_ports" {
    type = map(list(string))
  default = {
    "8091" = [ "10.1.2.0/24","10.2.2.0/24" ]
    "22" = ["10.0.0.0/8"]
  }
}
variable "vpc_id" {
   default = "vpc-07b12bcec12a4cd9b"
}