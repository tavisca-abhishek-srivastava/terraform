variable "keyName" {
   default = "mykey_test"
}
variable "privatekeyPath" {
   default = "/home/ec2-user/terraform/module-example/mykey_test.pem"
}
variable "publickeyName" {
   default = "mykey_test.pub"
}
variable "publickeyPath" {
   default = "/home/ec2-user/terraform/module-example/mykey_test.pub"
}