variable "aws_region" {
    type = string
  default = "us-east-1"
}

variable "project_tags" {
    type = map(string)
    default = {
      "Component" = "FrontEnd",
      "Environment" = "Production"
    }
  
}