resource "aws_lambda_function" "weather_fetcher" {
  function_name = "${var.project}-weather-fetcher-${var.environment}"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda.lambda_handler"
  runtime       = "python3.10"

  filename         = "producer/lambda.zip"
  source_code_hash = filebase64sha256("producer/lambda.zip")

  environment {
    variables = {
      BUCKET   = aws_s3_bucket.weather_raw.bucket
      API_KEY  = var.openweather_api_key
      LATITUDE = var.latitude
      LONGITUDE = var.longitude
    }
  }
}


# EventBridge rule
resource "aws_cloudwatch_event_rule" "every_minute" {
  name                = "${var.project}-every-minute"
  schedule_expression = "rate(5 minutes)"
}

# Target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule = aws_cloudwatch_event_rule.every_minute.name
  arn  = aws_lambda_function.weather_fetcher.arn
}

# Permission
resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.weather_fetcher.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_minute.arn
}

resource "aws_glue_trigger" "weather_schedule" {
  name     = "weather-batch-trigger"
  type     = "SCHEDULED"
  schedule = "cron(0/30 * * * ? *)" # every 30 minutes

  actions {
    job_name = aws_glue_job.weather_streaming_job.name
  }
}
