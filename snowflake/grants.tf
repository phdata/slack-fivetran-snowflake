resource snowflake_role_grants role_grant {
  role_name = snowflake_role.fivetran_autogen_role.name

  users     = [
    "${snowflake_user.fivetran_autogen_user.name}"
  ]
}

resource snowflake_database_grant db_grant_usage {
  database_name     = snowflake_database.fivetran_autogen_db.name
  for_each          = toset( var.db_privileges )

  privilege         = each.key
  roles             = [
    "${snowflake_role.fivetran_autogen_role.name}"
  ]

  with_grant_option = false
}

resource snowflake_warehouse_grant wh_grant {
  warehouse_name    = snowflake_warehouse.fivetran_autogen_wh.name
  privilege         = "USAGE"

  roles             = [
    "${snowflake_role.fivetran_autogen_role.name}"
  ]

  with_grant_option = false
}