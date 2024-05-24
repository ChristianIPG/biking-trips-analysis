# SCRIPT 1: Loading data (ETL)
# This script includes the loading of datasets and some initial data exploration, the creation of new useful variables based on the existing information, data cleaning and transformation. These are the preparations before starting the analysis.

# DOWNLOAD THE DATA
# You can download the data files directly from Kaggle following the link: www.kaggle.com/datasets/christianpartal/bikingdata
# It will download as a ZIP file. Save its content in a folder named 'Dataset'. You will then set the folder containing this as your working directory.

# LOADING THE DATA
# Given that our data is structured in the form of 12 separate csv files, we must first upload and unite them into a single, large, structured dataset.
# First we install the needed package to read_csv, which can make tibbles. tidyverse includes useful libraries like dplyr, ggplot2, etc.
install.packages("readr")
library(tidyverse)


# Our data is in a monthly format. We name and import the first dataset as a tibble using read_csv:
c202106 <- read_csv("202106-divvy-tripdata.csv")
c202107 <- read_csv("202107-divvy-tripdata.csv")
c202108 <- read_csv("202108-divvy-tripdata.csv")
c202109 <- read_csv("202109-divvy-tripdata.csv")
c202110 <- read_csv("202110-divvy-tripdata.csv")
c202111 <- read_csv("202111-divvy-tripdata.csv")
c202112 <- read_csv("202112-divvy-tripdata.csv")
c202201 <- read_csv("202201-divvy-tripdata.csv")
c202202 <- read_csv("202202-divvy-tripdata.csv")
c202203 <- read_csv("202203-divvy-tripdata.csv")
c202204 <- read_csv("202204-divvy-tripdata.csv")
c202205 <- read_csv("202205-divvy-tripdata.csv")


# Before continuing further, to get a quick idea of what we are working with, we proceed to inspect the data. We inspect the first month for now to get a glimpse of the structure:
# head() returns the columns and first several rows of data, an intuitive way of looking at how the set is structured
head(c202106)
# colnames() is a simpler way of knowing which variables we have, through looking at the names of our columns 
colnames(c202106)
# summary() returns an overall summary of all these variables. Here we can see different information depending on the data type, such as the quartiles for numerical variables
summary(c202106)
# str() is another alternative, displaying the structure of our variables as well as some of the few first observations
str(c202106)
# glimpse() is yet another alternative
glimpse(c202106)

# Unite the 12 datasets into one, which we will call trips. This large dataset will contains all bicycle trips in the span of 12 months. Then we summarize the entirety of the data.
trips <- rbind(c202106,c202107,c202108,c202109,c202110,c202111,c202112,c202201,c202202,c202203,c202204,c202205)
summary(trips)


#  CREATING NEW VARIABLES: TRIP DURATION, DAY OF THE WEEK AND MONTH
#  We'll install lubridate to work with dates. Then we'll use the mutate() function from the dplyr package to add new columns.
library(lubridate)

#  Use the function wday to get the day of the week each trip started at (remember that 1=sunday). Similarly use the function month. 
#  We also include variables for the names of weekdays and months, using factor(), so it's a character variable which has levels.
trips <- trips %>%
  mutate(weekday = wday(started_at))  %>%
  mutate(weekday_n = factor(wday(started_at), labels = c("Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday")))  %>%
  mutate(month = month(started_at))   %>%
  mutate(month_n = factor(month(started_at), labels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")))

#  We create an important variable, the duration of the trip. Remember; time here is measured in seconds.
trips <- trips %>%
  mutate(duration = ended_at - started_at)


#  DATA CLEANING - PREPARATIONS FOR THE ANALYSIS AND VISUALIZATIONS
#  We check and make sure the variables make sense before starting our analysis, and fix any problems if necessary.
#  First we make sure the bike types in the dataset are only the three we expect. Using 'unique' we'll see there are indeed three: "classic_bike", "electric_bike" and "docked_bike". 
unique(trips$rideable_type)
#  And we check another important variable, the client categories, to make sure there are only the two types implied in the name. We indeed found two: "member" and "casual".
unique(trips$member_casual)

#  We now explore the newly created duration variable. Here we notice a potential error, that some trips have zero seconds, and some have negative seconds!
#  We see how many durations are negative (there are 139), and how many are exactly zero (there are 507):
nrow(trips[trips$duration < 0, ])
negativetrips <- subset(trips, duration < 0)
count(negativetrips)
zerotrips <- subset(trips, duration == 0) 
count(zerotrips)
positivetrips  <- subset(trips, duration > 0)
count(positivetrips)
#  Detecting this leads us to examine the dates of these trips, just in case some rider returned his bike the day after taking it.
head(negativetrips)
#  But given that our duration variable already takes dates into account, we conclude these observations really make no sense and they can be attributed to errors in the company's system.
#  The faulty 646 observations approximately make up to 0.011% of the total dataset, which is a reasonable margin of error:
paste( round( (count(negativetrips) + count(zerotrips)) / nrow(trips) * 100, 4), "%", sep = " ")
#  The observations with negative and zero duration will therefore be deleted. We create a new dataset of only positive duration trips:
ptrips <- trips[trips$duration > 0, ]

# We oserved, when first exploring the data, that many observations did not have values for the names and ID of the stations (neither the starting ones nor the ending ones), and also for the latitudes or longitudes.
# These null values can be caused by faulty machinery at the stations themselves, or other unexpected problems in how the company measures activity. In any case, it impacts the quality of our data and we must assess how many values are missing.
# We'll see that the number of observations with missing values regarding the stations is significant, so we will not rely much on them for our analysis.
null_start_station_name <- sum(is.na(ptrips$start_station_name))
null_start_station_id <- sum(is.na(ptrips$start_station_id))
null_end_station_name <- sum(is.na(ptrips$end_station_name))
null_end_station_id <- sum(is.na(ptrips$end_station_id))
null_start_station_name
null_start_station_id
null_end_station_name
null_end_station_id


# We proceed to prepare some useful vectors that we will later use as labels for analysis and visualizations.
# For the bike types:
biketypes <- unique(ptrips$rideable_type)
biketypes
# For the client types:
clienttypes <- unique(ptrips$member_casual)
clienttypes
# A vector for the days of the week
days <- levels(ptrips$weekday_n)
days
# And a vector for the months of the year
months <- levels(ptrips$month_n)
months
