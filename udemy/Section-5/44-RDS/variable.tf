variable "mysql_subnet_group" {
  default = "cxl-rds-subnet-group"
}

variable "name_of_security_groups" {
   default = "tapoc-mysql"
}
variable "sg_ingress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
      description = string
    }))
    default     = [
        {
          from_port   = 22
          to_port     = 22
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "SSH"
        },
        {
          from_port   = 3306
          to_port     = 3306
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "mysql"
        },
        {
          from_port   = 80
          to_port     = 80
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "HTTP"
        },
        {
          from_port   = 1494
          to_port     = 1494
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "Citrix"
        },
                {
          from_port   = 18091
          to_port     = 18091
          protocol    = "tcp"
          cidr_block  = "10.0.0.0/8"
          description = "Couchbase"
        },
    ]
}
variable "sg_egress_rules" {
    type = list(object({
      from_port   = number
      to_port     = number
      protocol    = string
      cidr_block  = string
        }))
    default     = [
        {
          from_port   = 0
          to_port     = 0
          protocol    = "-1"
          cidr_block  = "0.0.0.0/0"
         },
        
                ]
}
variable "vpc_id" {
   default = "vpc-07b12bcec12a4cd9b"
}