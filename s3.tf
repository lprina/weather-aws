resource "aws_s3_bucket" "weather_raw" {
  bucket = "${var.project}-raw-${var.environment}"
}

resource "aws_s3_bucket" "weather_processed" {
  bucket = "${var.project}-processed-${var.environment}"
}

resource "aws_s3_bucket" "glue_assets" {
  bucket = "${var.project}-glue-assets-${var.environment}"
}

resource "aws_s3_bucket" "glue_scripts" {
  bucket = "${var.project}-glue-scripts-${var.environment}"
}
