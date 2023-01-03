terraform {
  required_providers {
    snowflake = {
      source = "Snowflake-Labs/snowflake"
      version = "0.46.0"
    }
  }
}

data "snowflake_current_account" "account" {
  
}
