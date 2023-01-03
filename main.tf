terraform {
  #backend "s3" {
  #  key    = "slack-fivetran"
  #}
}

module "aws" {
    source = "./aws"
    
    policy_name = "fivetran-lambda-invoke-autogen"
    role_name = "fivetran_lambda_function_autogen"
    bucket_name = "slack-user-data-autogen"
    lambda_function_name = "slack_data_autogen"
    lambda_runtime = "python3.9"
    fivetran_account_id = "834469178297"

    fivetran_group_id = module.fivetran.group_id
}

module "fivetran" {
    source = "./fivetran"
    
    group_name = "Snowflake_Autogen"
    snowflake_destination_schema = "aws_lambda_autogen"
    region = "US"

    snowflake_host = module.snowflake.host
    snowflake_db_name = module.snowflake.db_name
    snowflake_role_name = module.snowflake.role_name
    snowflake_user_name = module.snowflake.user_login_name
    snowflake_password = module.snowflake.user_password

    lambda_function_name = module.aws.lambda_function_name
    lambda_role_arn = module.aws.role_arn
    lambda_aws_region = module.aws.region

    secrets = "{ \"consumerKey\": \"\", \"consumerSecret\": \"\", \"apiKey\": \"${var.slack_token}\" }"
}

module "snowflake" {
    source = "./snowflake"

    db_name = "FIVETRAN_AUTOGEN"
    db_privileges = [ "USAGE", "MODIFY", "CREATE SCHEMA" ]
    warehouse_name = "FIVETRAN_AUTOGEN_WH"
    warehouse_size = "XSMALL"
    user_name = "FIVETRAN_AUTOGEN_USER"
    role_name = "FIVETRAN_AUTOGEN_ROLE"
}
