Weather Streaming Data Pipeline (AWS)
 
## 1-Overview:

This project implements a serverless AWS-based data pipeline that:

-Periodically retrieves weather forecast data from the OpenWeather API.

-Stores raw JSON responses in Amazon S3.

-Processes precipitation forecasts using AWS Glue (Spark).

-Writes aggregated results into DynamoDB.

-The solution demonstrates cloud-native ingestion, batch processing, and analytics design.

## 2-Architecture:

Components used:

AWS Lambda → Weather data ingestion.

Amazon EventBridge → Lambda scheduling.

Amazon S3 → Raw & processed storage.

AWS Glue (Spark) → Batch transformation.

Amazon DynamoDB → Aggregated results.

## 3 - Instructions:

**Prerequisites**

Before running this project, ensure you have:

- AWS CLI installed
- Terraform installed
- An AWS account
- Configured AWS credentials


3.1 Run :

```
aws configure
```

Provide:

- AWS Access Key
- AWS Secret Key
- Default region (e.g. eu-west-1)
- Output format (json)

**Keys sent by email**

Validation

```
aws sts get-caller-identity
```
3.2 Terraform init

Run the following from root folder:

```
terraform init
```

