# DAGs Idea
I have some quite times to think what is the best DAGs and DBTs I should write into this repo. What I wanted to learn actually is a streaming cases, but Airflow is not the best place to do it. Airflow usage is the best approach on Batch. Let's lists down what I wanted to learn:
1. Lambda Architecture
Lambda Architecture is data architecture to accomodate Streaming table input and materialized it for analytics, so it uses both streaming and batch. However to accomodate streaming, i should use another services such as Kafka.
2. Star or Snowflake Schema
Using a fact table and dimensional table to demonstrate knowledge of data modelling.
3. Should i search the case involving GIS, an area where I good at? I dont know. We need to look up on the data.
4. I also want to do a batch with Spark (Data with > 100 gb), the problem is the storage. Where should i put it? I dont have the resources.
