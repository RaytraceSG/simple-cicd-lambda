# Create a zip file of the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

# Create the Lambda function
resource "aws_lambda_function" "example_lambda" {
  filename                       = "lambda_function.zip"
  function_name                  = "azmi1_lambda_function"
  role                           = aws_iam_role.lambda_role.arn
  handler                        = "lambda_function.lambda_handler"
  source_code_hash               = data.archive_file.lambda_zip.output_base64sha256
  runtime                        = "python3.10"
  reserved_concurrent_executions = 100
  tracing_config {
    mode = "Active"
  }
  #checkov:skip=CKV_AWS_116:AWS Lambda function is not configured for a DLQ
  #checkov:skip=CKV_AWS_272:Ensure AWS Lambda function is configured to validate code-signing
  #checkov:skip=CKV_AWS_117:Ensure that AWS Lambda function is configured inside a VPC
}