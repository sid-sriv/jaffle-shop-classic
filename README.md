# Fleetio Data Engineer Assessment

Welcome! Thank you for your interest in Fleetio. 

The following assessment is a semi-realistic scenario for a data engineer at Fleetio. There are no right or wrong answers and we are more interested in understanding how you approach the problem. Please write code in a manner as if you were collaborating with another member of the team. 

Please timebox this to no more than a couple of hours and remember that you will present your work to the rest of the team in the next stage. 

We hope you enjoy!

## Problem Statement
At Fleetio, we have many partners that sometime require special customizations in the data pipeline. In this scenario, we just signed a contract with a very large partner which stipulates that they will send us vehicle issue data using a shared google sheet. Even though they are a strategic partner, they are not as tech-savvy and do not have a dedicated IT department. Consequently, we've been asked to ingest the issue data whenever new entries are manually entered into the sheet and create visualizations for them to look at. 

As the data engineer assigned to this project, you will need to:
1. Build a custom ingestion from google sheets via API
2. Store the ingested data in a local database
3. Model the data so that it is easy for other team members to build visualizations with

## Task 1: Fetch the data from google sheets API
Make a copy of the csv file inside the `data/` directory into your own personal google drive. Write data ingestion scripts in python to fetch the data using the google sheets API.


#### For Discussion Only 
How would you check for updates in the sheet?

In a production environment, the most reliable way to check for updates in a Google Sheet would be to use the Google Sheets API to periodically fetch the data and compare it against the last fetched record. There are a few ways to approach this:
	1.	Time-based checks: Use a timestamp column in the sheet to identify new or updated records since the last run. If the sheet includes a “last updated” or “created at” column, we could filter by that to only process new or updated rows.
	2.	Row-based tracking: Track the last row number fetched, and during each fetch, pull all rows after that. This method could be paired with a unique key column (e.g., issue_id) to ensure no new rows are missed.
	3.	Change detection: If the sheet is too large for efficient polling, we could implement a webhook mechanism using the Google Sheets API to notify us when new data is added. However, this would require additional complexity and potentially external services for webhook management.

To orchestrate this script, tools like dbt Cloud, Apache Airflow, or GitHub Actions could be used to schedule the script to run at regular intervals (e.g., every hour, daily) to ensure that the data is consistently pulled and ingested into the database.


How would you orchestrate this script in a production setting?

1. dbt Cloud: Since dbt Cloud supports scheduling and monitoring dbt models, it would be an ideal place to orchestrate the entire data pipeline once the data is ingested. It also integrates with major cloud data warehouses (e.g., Snowflake, BigQuery, etc.), which would streamline the pipeline.

2. Apache Airflow: A more customizable approach would be to use Airflow. With Airflow, you can define workflows with more flexibility and implement complex scheduling, retry logic, and branching logic based on specific conditions (e.g., only run if new data is detected).

3. GitHub Actions: For a more straightforward solution, you can use GitHub Actions for lightweight orchestration, especially if the processing logic is simple and doesn’t require a heavy-duty orchestration framework.


## Task 2: Persist the data into a relational database on your local machine
Please spin up a local relational database and persist the data into a table in your database.

## Task 3: Clean and model the data for later visualization
Once the data is inside the database, please clean/model the data using sql or dbt. Please create models that would make it easy for a data analyst to build week over week trending dashboards.


## Task 4: Make the code production ready
Please write tests, format and make the repository "production-ready" in your mind. 


#### For Discussion Only 
- Given more time, what else would you have liked to do?
  
1.	Used OAuth for Google Sheets: For security reasons, OAuth would have been a more secure option than API keys, particularly in a production setting. This would also provide finer control over permissions, ensuring only the necessary accounts can access the sheet.
2.	Stick with Snowflake from the beginning: While I initially set up for SQLite and DuckDB, these required significant work to ensure compatibility with the rest of the system, especially with dbt core. I encountered some bugs with dbt core and SQLite, one of which I reported to dbt Labs, and struggled with getting it fully functional. This led me to switch to DuckDB, learning it on the go. Snowflake would have been the most seamless solution, as my system was already pre-configured for the previous data stack I had worked with. Using Snowflake directly would have saved time, avoided extra effort in troubleshooting compatibility issues, and ensured I could focus on modeling the data efficiently with debt from the start, as I spent a considerable amount of time removing centralized variables and dependencies from my system first.
3.	Focus on the Egress: Since the ingestion side was primarily handled, I would have focused more on the egress side, ensuring data can be exported and used for visualization with tools like Tableau, Power BI, or Looker, particularly focusing on performance and schema management.
4.	Data Observability: Ensuring that the pipeline is observable and tracking any schema drifts, data quality issues, and errors. This could be accomplished by integrating tools like Monte Carlo or Metaplane to monitor data quality. This would ensure that data flowing through the pipeline is trustworthy. 

- If you were assigned this problem in real life, what other approaches would you have taken?

  1. Used Fivetran for Ingestion: Given that Fleetio already uses Fivetran, I would have opted to use Fivetran to automate the ingestion of the Google Sheet data. Fivetran offers pre-built connectors for Google Sheets and eliminates the need to maintain API-based ingestion scripts. This would also allow us to leverage Fivetran’s built-in metadata management, which provides more visibility and observability over the data pipeline and, hence, not lose any data fidelity with API ingestion.
	2.	Use Snowflake and dbt: Since Fleetio uses Snowflake as its data warehouse, I would have directly ingested the data into Snowflake using Fivetran and then modeled the data with dbt. Snowflake is highly scalable, and dbt offers an easy way to model the data for analysts, making it an ideal choice for both performance and collaboration.
	3.	Orchestration with dbt Cloud or Airflow: To manage the workflow, I would use dbt Cloud if the team is already using dbt for modeling. This would allow us to schedule and monitor the entire pipeline easily. Alternatively, Apache Airflow could be used if we need more control over the orchestration, such as handling dependencies between tasks.
	4.	Implement A/B Testing for Development vs. Production: I would have used Datafold or another data validation tool to compare development environments with production. This ensures that our changes in dbt models do not unintentionally break anything in the production environment.
	5.	Ensure Data Governance and Security: A solution like Monte Carlo or Metaplane for observability and Looker or Tableau for data visualization would be used to ensure stakeholders have visibility into the data, and data governance is well handled.

## Submission
Once you are done, please zip up the entire repo and send it to your recruiter. We ask for the entire zipped repository so that we can take a look at the git log. 

Thanks! We sincerely appreciate you taking the time to go through this assessment.


