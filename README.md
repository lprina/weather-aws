Weather Streaming Data Pipeline (AWS)
 
**1-Overview:**

This project implements a serverless AWS-based data pipeline that:

-Periodically retrieves weather forecast data from the OpenWeather API.

-Stores raw JSON responses in Amazon S3.

-Processes precipitation forecasts using AWS Glue (Spark).

-Writes aggregated results into DynamoDB.

-The solution demonstrates cloud-native ingestion, batch processing, and analytics design.

**2-Architecture:**

Components used:

AWS Lambda → Weather data ingestion.

Amazon EventBridge → Lambda scheduling.

Amazon S3 → Raw & processed storage.

AWS Glue (Spark) → Batch transformation.

Amazon DynamoDB → Aggregated results.






```python
print("Hello")
```


```python
print("Hello")
```