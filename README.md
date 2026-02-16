Weather Streaming Data Pipeline (AWS)
 Overview

This project implements a serverless AWS-based data pipeline that:

Periodically retrieves weather forecast data from the OpenWeather API

Stores raw JSON responses in Amazon S3

Processes precipitation forecasts using AWS Glue (Spark)

Writes aggregated results into DynamoDB

The solution demonstrates cloud-native ingestion, batch processing, and analytics design.

Architecture

Components used:

AWS Lambda → Weather data ingestion

Amazon EventBridge → Lambda scheduling

Amazon S3 → Raw & processed storage

AWS Glue (Spark) → Batch transformation

Amazon DynamoDB → Aggregated results

Data Flow

Lambda Function

Triggered every 5 minutes

Calls OpenWeather API

Stores raw JSON into S3

Glue Batch Job

Triggered every 30 minutes

Reads JSON from S3

Flattens minutely forecast data

Aggregates precipitation

Writes results to DynamoDB