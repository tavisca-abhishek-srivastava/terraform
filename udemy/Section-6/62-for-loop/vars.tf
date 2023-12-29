variable "list1" {
    type = list(number)
    default = [ 1,2,3,4,5,6 ]
  
}
variable "list2" {
    type = list(string)
    default = [ "apple","pear","mango","banana" ]
    }

variable "map1" {
  type = map(number)
  default = {
    "apple" = 10,
    "pear"= 20,
    "banana" = 30,
    "mango" = 40
  }
}