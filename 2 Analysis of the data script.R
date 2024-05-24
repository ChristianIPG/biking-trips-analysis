#  Script 2: ANALYSIS OF THE DATA
#  In this script we calculate some analytical measures, and present them structured in table format.

#  Number of trips (total across the 12 months)
num_trips <- nrow(ptrips)
#  Number of trips based on client type
num_trips_memb <- nrow(subset(ptrips, member_casual == "member"))
num_trips_casu <- nrow(subset(ptrips, member_casual == "casual"))
#  Number of trips based on bike type
num_trips_clas <- nrow(subset(ptrips, rideable_type == "classic_bike"))
num_trips_elec <- nrow(subset(ptrips, rideable_type == "electric_bike"))
num_trips_dock <- nrow(subset(ptrips, rideable_type == "docked_bike"))

#  Mean durations
sum_durations <- sum(ptrips$duration)
mean_durations <- mean(ptrips$duration)
#  Durations based on client type. We'll notice that on average, the trips of casual clients are noticeable longer than those of member clients.
mean_durations_memb <- mean(subset(ptrips, member_casual == "member")$duration)
mean_durations_casu <- mean(subset(ptrips, member_casual == "casual")$duration)
#  Durations based on bike type. We'll see that docked bikes take on average longer trips, followed by classic bikes and finally electric bikes.
mean_durations_clas <- mean(subset(ptrips, rideable_type == "classic_bike")$duration)
mean_durations_elec <- mean(subset(ptrips, rideable_type == "electric_bike")$duration)
mean_durations_dock <- mean(subset(ptrips, rideable_type == "docked_bike")$duration)

# We put the values in tables to compare the number of trips and mean duration of trips. We format both columns appropriately so duration is in mm:ss format.
#   A table to compare between member types
clientcompare = matrix (c(num_trips_memb, mean_durations_memb, num_trips_casu, mean_durations_casu), ncol=2, byrow=TRUE)
colnames(clientcompare) = c("Total trips","Mean duration (m:s)")
rownames(clientcompare) <- clienttypes
clientcompare[, 1] <- round(clientcompare[, 1])
clientcompare[, 2] <- format(as.POSIXct(clientcompare[, 2], origin = "1970-01-01"), format = "%M:%S")
clienttable=as.table(clientcompare)
clienttable
#   And a table to compare between bike types:
bikecompare = matrix (c(num_trips_elec, mean_durations_elec, num_trips_clas, mean_durations_clas, num_trips_dock, mean_durations_dock), ncol=2, byrow=TRUE)
colnames(bikecompare) = c("Total trips","Mean duration (m:s)")
rownames(bikecompare) <- biketypes
bikecompare[, 1] <- round(bikecompare[, 1])
bikecompare[, 2] <- format(as.POSIXct(bikecompare[, 2], origin = "1970-01-01"), format = "%M:%S")
biketable=as.table(bikecompare)
biketable

# Count how many trips by client type and by bike type simultaneously
clas_m <- nrow(ptrips[ptrips$rideable_type == "classic_bike" & ptrips$member_casual == "member", ])
clas_c <- nrow(ptrips[ptrips$rideable_type == "classic_bike" & ptrips$member_casual == "casual", ])
elec_m <- nrow(ptrips[ptrips$rideable_type == "electric_bike" & ptrips$member_casual == "member", ])
elec_c <- nrow(ptrips[ptrips$rideable_type == "electric_bike" & ptrips$member_casual == "casual", ])
dock_m <- nrow(ptrips[ptrips$rideable_type == "docked_bike" & ptrips$member_casual == "member", ])
dock_c <- nrow(ptrips[ptrips$rideable_type == "docked_bike" & ptrips$member_casual == "casual", ])
bike_clients <- matrix(c(clas_m,elec_m,dock_m,clas_c,elec_c,dock_c), ncol=3, byrow=TRUE)
colnames(bike_clients) <- biketypes
rownames(bike_clients) <- clienttypes
bike_clientstable = as.table(bike_clients)
bike_clientstable
# We also save these values as vectors for future visualization
clas_clients <- bike_clients[,1]
elec_clients <- bike_clients[,2]
dock_clients <- bike_clients[,3]


#  Count how many trips per day of the week
# Matrix and table of results:
weektrips <- matrix(c(nrow(ptrips[ptrips$weekday == "1", ]), nrow(ptrips[ptrips$weekday == "2", ]), nrow(ptrips[ptrips$weekday == "3", ]), nrow(ptrips[ptrips$weekday == "4", ]), 
             nrow(ptrips[ptrips$weekday == "5", ]), nrow(ptrips[ptrips$weekday == "6", ]), nrow(ptrips[ptrips$weekday == "7", ])), ncol=7, byrow=TRUE)
colnames(weektrips) <- days
rownames(weektrips) <- c("Total trips")
weektripstable = as.table(weektrips)
weektripstable

#  Length of trip duration. Workdays vs weekends.
mean_duration_workdays <- ptrips %>%
  filter(weekday_n %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")) %>%
  summarise(mean_duration = mean(duration))
mean_duration_weekends <- ptrips %>%
  filter(weekday_n %in% c("Saturday", "Sunday")) %>%
  summarise(mean_duration = mean(duration))
weekdurationtable <- rbind(mean_duration_workdays, mean_duration_weekends)
weekdurationtable <- as.data.frame(weekdurationtable)
rownames(weekdurationtable) <- c("Workdays", "Weekends")
weekdurationtable
percentage_increase <- ((as.numeric(mean_duration_weekends$mean_duration) - as.numeric(mean_duration_workdays$mean_duration)) / (as.numeric(mean_duration_workdays$mean_duration)) ) * 100
paste("Bike trips during weekdays are on average", round(percentage_increase, 2), "% longer than on weekends.")


# Count by day of the week and by client type simultaneously
#   For much better efficiency and speed, we'll use a for loop in this and other subsequent tables, instead of calculating each value one by one
#   So first we create an empty matrix to store the counts. We can do this because we already know the size of the result. Then the loop will add the values
weekclients <- matrix(0, nrow = length(clienttypes), ncol = length(days), dimnames = list(clienttypes, days))
for (i in 1:length(clienttypes)) {
    for (j in days) {
       count <- nrow(ptrips[ptrips$weekday_n == j & ptrips$member_casual == clienttypes[i], ])
       weekclients[i, which(days == j)] <- count
    }
}
#   Convert matrix to table
weekclienttable <- as.table(weekclients)
weekclienttable


# Count how many trips per month
monthtrips <- matrix(0, nrow = 1, ncol = length(months), dimnames = list("Total trips", months))
for (i in months) {
  count <- nrow(ptrips[ptrips$month_n == i, ])
  monthtrips[1, which(months == i)] <- count
}
monthtripstable <- as.table(monthtrips)
monthtripstable


# Count by month and by client type simultaneously.
monthclients <- matrix(0, nrow = length(clienttypes), ncol = length(months), dimnames = list(clienttypes, months))
for (i in 1:length(clienttypes)) {
    for (j in months) {
       count <- nrow(ptrips[ptrips$month_n == j & ptrips$member_casual == clienttypes[i], ])
       monthclients[i, which(months == j)] <- count
    }
}
# Convert matrix to table
monthclienttable <- as.table(monthclients)
monthclienttable


# Count total trips for each type of bike across the months of the year
electricbymonth <- sapply(months, function(month) {
  nrow(ptrips[ptrips$month_n == month & ptrips$rideable_type == "electric_bike", ]) })
classicbymonth <- sapply(months, function(month) {
  nrow(ptrips[ptrips$month_n == month & ptrips$rideable_type == "classic_bike", ])  })
dockedbymonth <- sapply(months, function(month) {
  nrow(ptrips[ptrips$month_n == month & ptrips$rideable_type == "docked_bike", ])   })


# Printing tables
print("SUMMARY TABLES")
print("Table 1: Client types comparison")
print(clienttable)

print("Table 2: Bike service comparison")
print(biketable)

print("Table 3: Number of trips by client type and bike type")
print(bike_clientstable)

print("Table 4: Bike trips by day of the week")
print(weektripstable)

print("Table 5: Bike trips - weekdays vs weekends")
print(weekdurationtable)
print(paste("Bike trips during weekdays are on average", round(percentage_increase, 2), "% longer than on weekends."))

print("Table 6: Client type by day of the week")
print(weekclienttable)

print("Table 7: Bike trips by month")
print(monthtripstable)

print("Table 8: Client type by month")
print(monthclienttable)
