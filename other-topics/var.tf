variable "name_in_lower" {
  
type = string

validation {
  condition = var.name_in_lower == lower(var.name_in_lower)
  error_message = "name is not lower"
}

}

output "name_in_lower" {
  value = var.name_in_lower
}