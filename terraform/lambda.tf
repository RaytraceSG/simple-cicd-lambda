# Create a zip file of the Lambda function code
data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "lambda_function.py"
  output_path = "lambda_function.zip"
}

# Create the Lambda function
resource "aws_lambda_function" "example_lambda" {
  filename         = "lambda_function.zip"
  function_name    = "azmi1_lambda_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.10"
}