resource "aws_glue_job" "weather_streaming_job" {
  name     = "${var.project}-glue-batch-${var.environment}"
  role_arn = aws_iam_role.glue_role.arn

  execution_property {
    max_concurrent_runs = 3
  }

  command {
    name            = "glueetl"
    script_location = "s3://${aws_s3_bucket.glue_scripts.bucket}/weather_batch_job.py"
    python_version  = "3"
  }

  glue_version      = "4.0"
  number_of_workers = 2
  worker_type       = "G.1X"

  default_arguments = {
    "--job-language"     = "python"
    "--raw_bucket"       = aws_s3_bucket.weather_raw.bucket
    "--processed_bucket" = aws_s3_bucket.weather_processed.bucket
    "--TempDir"          = "s3://${aws_s3_bucket.weather_processed.bucket}/temp/"

  }
}
