variable "keys" {
  type    = list
  default = ["name", "age"]
}

variable "values" {
  type    = list
  default = ["Alice", 30]
}

output "my_map" {
value = zipmap(var.keys, var.values)
}      
# Returns my_map = tomap({
"age" = "30"
"name" = "Alice"
})
