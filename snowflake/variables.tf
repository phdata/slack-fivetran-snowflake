variable "db_privileges" {
  type      = list(string)
}

variable "db_name" {
  type      = string
}

variable "warehouse_name" {
  type      = string
}

variable "warehouse_size" {
  type    = string


  validation {
    condition     = contains(["XSMALL", "SMALL"], var.warehouse_size)
    error_message = "Allowed values for warehouse_size are \"XSMALL\" or \"SMALL\"."
  }
}

variable "user_name" {
  type      = string
}

variable "role_name" {
  type      = string
}
