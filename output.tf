output "raw_bucket" {
  value = aws_s3_bucket.weather_raw.bucket
}

output "processed_bucket" {
  value = aws_s3_bucket.weather_processed.bucket
}

output "glue_assets_bucket" {
  value = aws_s3_bucket.glue_assets.bucket
}

output "glue_job_name" {
  value = aws_glue_job.weather_streaming_job.name
}
