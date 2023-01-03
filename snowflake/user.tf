resource snowflake_user fivetran_autogen_user {
  name                  = var.user_name
  password              = random_password.password.result
  disabled              = false

  default_warehouse     = snowflake_warehouse.fivetran_autogen_wh.name
  default_role          = snowflake_role.fivetran_autogen_role.name

  must_change_password  = false
}

resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "!#%"
}