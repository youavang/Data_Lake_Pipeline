# Data Lake Pipeline with with AWS EMR, AWS S3, Spark and Databricks

Every year the United States Census Bureau conduct a census to get a count of the population and to get data about its people and economy. Data collected from the census helps the U.S. government to determine the number of seats each state has in the U.S. House of Representatives and to distribute federal funds to local communities. For this analysis, data is extracted from census.gov and flows through a data pipeline, in which it goes through transformation and analysis. 

The resources used in the data pipeline are AWS S3 buckets, AWS EMR, Pyspark and Databricks. Here a generalized flow of the data pipeline:

![flow](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/EMR-Spark-Databricks.jpg)

The process in data pipeline includes the following:

1.	Create an AWS EMR cluster.
2.	SSH to the EMR master node.
3.	Configure AWS credential.
4.	Update the node.
5.	Set up the Python environment.
6.	Start a Pyspark session.
7.	Import dependencies.
8.	Extract the data from census.gov via API.
9.	Transform the data into a Spark dataframe.
10.	Save the dataframe into an S3 bucket in csv format.
11.	Mount the S3 bucket in Databricks.
12.	Extract the data from the S3 bucket.
13.	Transform the dataframe to human readable format.
14.	Analyze the data.
15.	Store transformed data in S3 bucket in csv format.

A major challenge I faced, was not having the resources to integrate Databricks with AWS. I was using the Community Databricks and the free tier of AWS Services, so there are restrictions to what resources are available to me. I overcame this challenge by mounting the S3 bucket in Databricks and was able to create a seemless data pipeline.

![1Spark](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/01-Spark.png)
![2Spark](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/02-Spark.png)
![3Spark](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/03-Spark.png)
![4Spark](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/04-Spark.png)
![1S3conf](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/01-S3-conf.png)
![1db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/1-Databricks.png)
![2db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/2-Databricks.png)
![3db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/3-Databricks.png)
![4db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/4-Databricks.png)
![5db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/5-Databricks.png)
![6db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/6-Databricks.png)
![7db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/7-Databricks.png)
![8db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/8-Databricks.png)
![9db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/9-Databricks.png)
![10db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/10-Databricks.png)
![11db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/11-Databricks.png)
![12db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/12-Databricks.png)
![13db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/13-Databricks.png)
![14db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/14-Databricks.png)
![15db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/15-Databricks.png)
![16db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/16-Databricks.png)
![17db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/17-Databricks.png)
![18db](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/18-Databricks.png)
![2S3conf](https://github.com/youavang/Data_Lake_Pipeline/blob/main/Databricks_ETL_images/S3-conf.png)
