# How can biking behaviour drive a speedy business?

## Project Description
The following project analyses consumer behaviour for a bicycle rental business.
The analysis focuses on identifying differentiated consumer trends, preferred product categories and general consumer behaviour. This type of analysis can be particularly useful for the Marketing Analytics team, directed at informing the Executive Team of beneficial approaches in marketing strategy that will ultimately increase revenue for the company.

## Data
The data analysed is real, although anonymized. For data protection, the real name of the company and all client information has been erased from the dataset. Most of the analysis will focus on what can be extracted from the service information itself. It is also a very large dataset, containing above 5,8 million observations. Due to the large size of the data, the code is designed to be efficient in time and calculations.
The original data is structured as 12 csv files, one for each month of the year from June 2021 to June 2022, representing all bycicle trips registered by the business in a span of a year. During the project we will see how to upload, transform, unite and clean this data. Some initial exploratory analysis will be performed, and new variables will be created based on the existing information, data analysis with visualizations will follow, from which we can extract data-driven business insights. 
It contains variables for: ride_id (ID code of the ride), rideable_type (which tells us which type of bike was used. It can be an electric bike, a classic bike or a docked bike), started_at (date and time when the ride started), ended_at (date and time when the ride ended), start_station_name, start_station_id, end_station_name, end_station_id, start_lat (latitude of starting station), start_lng (longitude of starting station), end_lat (latitude of ending station), end_lng (longitude of ending station), member_casual (a variable which tells us the type of consumer, which can be "member" if he has purchased an anual membership, or "casual" if he has only paid for this trip in particular).

## How to run
You will need appropriate software to run the R script. RGui can be installed following this link:
www.r-project.org
You can also use R Studio.

The csv data, being too large to be uploaded in GitHub, can be found and downloaded in the following Kaggle link:
www.kaggle.com/datasets/christianpartal/bikingdata
Make sure to save it in a folder and when opening RGui, assign that folder as your working directory.

R scripts are provided with the code necessary for analysis. The code contains annotations explaining the different steps and approaches taken.
The scripts include the loading of datasets and initial data exploration, the creation of new variables, finding potential problems and fixing them, cleaning the data, analyzing the data by finding patterns, comparing elements, and concluding valuable insights about the business that can translate into clear business decissions that will positively impact the company performance.
