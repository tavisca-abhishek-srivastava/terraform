variable "tags" {
  type = object({
    AppName             =   string
    Backup              =   string
    BusinessUnit        =   string
    DataClassification  =   string
    Environment         =   string
    InfraOwner          =   string
    Name                =   string
    Product             =   string
    #Squad               =   string
  })
}
variable "instance_type" {
  type = map(object({
    name = string,
    region = string
  }))
  
}