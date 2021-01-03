

### DynamoDB Table
### Copypasta example from TF docs
### See: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table
resource "aws_dynamodb_table" "example" {
  name             = "example"
  hash_key         = "TestTableHashKey"
  billing_mode     = "PAY_PER_REQUEST"
  stream_enabled   = true
  stream_view_type = "NEW_AND_OLD_IMAGES"

  attribute {
    name = "TestTableHashKey"
    type = "S"
  }
}

### Lambda Handler
resource "aws_lambda_function" "dynamodb_stream_lambda" {
    filename = "../build/lambda.zip"
    function_name = "dynamodb-stream-lambda"
    handler = "app.handler"
    timeout = 15
    memory_size = 128
    runtime = "python3.7"
    role = var.aws_lambda_assume_role_arn
    source_code_hash = filebase64sha256("../build/lambda.zip")

    tags = {
        Name = "DynamoDB Stream Lambda"
    }
}

### Event Mapping
resource "aws_lambda_event_source_mapping" "ddb_stream_lambda_mapping" {
  event_source_arn  = aws_dynamodb_table.example.stream_arn
  function_name     = aws_lambda_function.dynamodb_stream_lambda.arn
  starting_position = "LATEST"
}
