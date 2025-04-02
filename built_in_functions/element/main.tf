variable "my_list" {
  type    = list
  default = ["apple", "banana", "cherry"]
}

output "selected_element" {
  value = element(var.my_list, 1) # Returns "banana"
}
