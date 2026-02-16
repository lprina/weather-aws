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


**3.1 Run :**

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
**3.2 tfvars creation**

On the root folder:

```
touch terraform.tfvars
```
and ADD in the file:

```
openweather_api_key = "9999999999999999"
```
Replace by the API key sent by email


**3.3 Terraform init**

Run the following from root folder:

```
terraform init
```
When its done:

```
terraform apply
```

## 4 -Testing AWS Components


**4.1 Test Lambda function**

```
aws lambda invoke \
  --function-name weather-streaming-weather-fetcher-dev \
  response.json \
  --region eu-west-1
```

**4.2 Verify data in S3**

```
aws s3 ls s3://weather-streaming-raw-dev/weather/
```

***4.3 Run glue job ( optional)**

```
aws glue start-job-run \
  --job-name weather-streaming-glue-batch-dev \
  --region eu-west-1
```

***4.4 Check glue logs **

```
aws logs tail /aws-glue/jobs/output --since 10m
```

## Are you done testing?

Run:

```
aws s3 rm weather-streaming-glue-scripts-dev --recursive
aws s3 rm weather-streaming-processed-dev --recursive
aws s3 rm weather-streaming-raw-dev
```

```
terraform destroy
```


