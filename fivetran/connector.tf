resource "fivetran_connector" "lambda_connector" {
    group_id            = fivetran_group.group.id
    service             = "aws_lambda"
    sync_frequency      = 1440
    daily_sync_time     = "14:00"
    paused              = false
    pause_after_trial   = false
    run_setup_tests     = true

    destination_schema {
        name = var.snowflake_destination_schema
    } 

    config {
        function = var.lambda_function_name
        role_arn = var.lambda_role_arn
        region   = var.lambda_aws_region
        secrets  = var.secrets
    }
}