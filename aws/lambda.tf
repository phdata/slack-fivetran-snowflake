resource "aws_lambda_function" "lambda_function" {
  filename          = data.archive_file.lambda_zip.output_path
  function_name     = var.lambda_function_name
  role              = aws_iam_role.iam_for_lambda.arn
  handler           = "function.lambda_handler"

  source_code_hash  = data.archive_file.lambda_zip.output_base64sha256

  runtime           = var.lambda_runtime
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  output_path = "${path.module}/tmp/lambda.zip"
  source_dir  = "${path.module}/lambda/"
}