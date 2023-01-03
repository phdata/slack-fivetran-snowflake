variable "group_name" {
  type      = string
}

variable "snowflake_destination_schema" {
  type      = string
}

variable "region" {
  type    = string

  validation {
    condition     = contains(["AWS_US_EAST_1", "US"], var.region)
    error_message = "Allowed values for fivetran_region are \"AWS_US_EAST_1\"."
  }
}

variable "snowflake_host" {
  type    = string
}

variable "snowflake_user_name" {
  type    = string
}

variable "snowflake_password" {
  type    = string
}

variable "snowflake_db_name" {
  type    = string
}

variable "snowflake_role_name" {
  type    = string
}

variable "lambda_function_name" {
  type    = string
}

variable "lambda_role_arn" {
  type    = string
}

variable "lambda_aws_region" {
  type    = string
}

variable "secrets" {
  type    = string 
}
