variable "project" {
  default = "weather-streaming"
}

variable "environment" {
  default = "dev"
}

variable "region" {
  default = "eu-west-1"
}

variable "openweather_api_key" {
  description = "OpenWeather API Key"
  sensitive   = true
}

variable "latitude" {
  default = "52.084516"
}

variable "longitude" {
  default = "5.115539"
}
