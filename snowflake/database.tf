resource "snowflake_database" "fivetran_autogen_db" {
  name                        = var.db_name
  data_retention_time_in_days = 0
}