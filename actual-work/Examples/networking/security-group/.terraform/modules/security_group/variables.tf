variable "name" {
  description = "The name of the security group"
  type        = string
  default     = "default-sg"
}

variable "description" {
  description = "The description of the security group"
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "ingress_rules" {
  description = "A list of ingress rules for the security group"
  type        = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups    = list(string)
    self = bool
  }))
  default     = []
}

variable "egress_rules" {
  description = "A list of egress rules for the security group"
  type        = list(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    security_groups    = list(string)
    self = bool
  }))
  default     = []
}
