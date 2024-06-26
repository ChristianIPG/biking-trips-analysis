# How biking behaviour can drive a speedy business

## Project Description
The following project analyses consumer behaviour for a bicycle rental business.
The analysis focuses on identifying differentiated consumer trends, preferred product categories and general consumer behaviour, by using a large scale, real dataset.
This type of analysis can be particularly useful for the Marketing Analytics team, to inform executive teams of beneficial approaches in marketing strategy, and to operations, in order to ultimately improve the service to clients and increase revenue for the company.

## Data
The data analysed is real, although anonymized. For data protection, the real name of the company and all client information has been erased from the dataset. Most of the analysis will focus on what can be extracted from the service information itself. It is also a very large dataset, containing above 5,8 million observations. Due to the large size of the data, the code is designed to be efficient in time and calculations.

The original data is structured as 12 csv files, one for each month of the year from June 2021 to June 2022, representing all bycicle trips registered by the business in a span of a year. During the project we will see how to upload, transform, unite and clean this data. Some initial exploratory analysis will be performed, and new variables will be created based on the existing information, data analysis with visualizations will follow, from which we can extract data-driven business insights. 

It contains variables for: ride_id (ID code of the ride), rideable_type (which tells us which type of bike was used. It can be an electric bike, a classic bike or a docked bike), started_at (date and time when the ride started), ended_at (date and time when the ride ended), start_station_name, start_station_id, end_station_name, end_station_id, start_lat (latitude of starting station), start_lng (longitude of starting station), end_lat (latitude of ending station), end_lng (longitude of ending station), member_casual (a variable which tells us the type of consumer, which can be "member" if he has purchased an anual membership, or "casual" if he has only paid for this trip in particular).

## How to run
You will need appropriate software to run the R script. An IDE like RStudio is a good option. So is RGui, which be installed following this link:
www.r-project.org

The csv data, being too large to be uploaded in GitHub, can be found and downloaded in the following Kaggle link:
www.kaggle.com/datasets/christianpartal/bikingdata

Make sure to save the dataset in a folder and then assign that folder as your working directory.

R scripts are provided with the code necessary for analysis. The code contains annotations explaining the different steps and approaches taken.
The scripts include the loading of datasets and initial data exploration, the creation of new variables, finding potential problems and fixing them, cleaning the data, analyzing the data by finding patterns, comparing elements, and concluding valuable insights about the business. These can translate into specific marketing and business decissions that will positively impact the company.
