variable "myvar" {
    type = string
    description = "(optional) describe your variable"
    default = "hello terraform"
}
variable "mymap" {
    type = map(string)
    description = "(optional) describe your variable"
    default = {
        name = "Abhishek"
        sir_name = "Srivastava"
    }
}