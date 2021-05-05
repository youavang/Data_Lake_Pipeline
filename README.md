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

