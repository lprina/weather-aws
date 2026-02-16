resource "aws_dynamodb_table" "weather_aggregated" {
  name         = "weather-aggregated"
  billing_mode = "PAY_PER_REQUEST"

  hash_key  = "lat"
  range_key = "lon"

  attribute {
    name = "lat"
    type = "N"
  }

  attribute {
    name = "lon"
    type = "N"
  }
}
