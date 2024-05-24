#  VISUALIZATIONS

# Some useful vectors 
# Vector with the number of trips for each type of client, which we calculated earlier
totaltripsbyclient <- c(num_trips_memb, num_trips_casu)
# Vector with the number of trips for each type of client, which we calculated earlier
totaltripsbybike <- c(num_trips_elec, num_trips_clas, num_trips_dock)

# Graph 1: Pie chart of the total number of trips by client type
# we want to add the corresponding percentages to the visualization, so we prepare them in advance.
totaltripsbyclient_percent <- round(100 * totaltripsbyclient / sum(totaltripsbyclient), 1)
totaltripsbyclient_labels <- paste(clienttypes, totaltripsbyclient_percent, "%", sep = " ")
pie(totaltripsbyclient, labels = totaltripsbyclient_labels, main = "Trips by client type", col = c("green","red4"))

# Alternatively we could also use the "scales" library in this way:
# install.packages("scales")
# library(scales)
# pie(totaltripsbyclient, labels = paste(clienttypes, percent(totaltripsbyclient / sum(totaltripsbyclient))), main = "Trips by client type", col =c("green","red4"))

# Graph 2: Bar plot comparing both types of client by mean duration
mean_dur_memb_seconds <- as.numeric(mean_durations_memb)
mean_dur_casu_seconds <- as.numeric(mean_durations_casu)
graph2 <- barplot(c(mean_dur_memb_seconds, mean_dur_casu_seconds),
           names.arg = c("Members", "Casuals"), main = "Mean trip duration by client type",
           xlab = "Client Type", ylab = "Mean Duration (seconds)", col = c("green", "red4"),
           ylim = c(0, max(mean_dur_memb_seconds, mean_dur_casu_seconds) * 1.1))    # Setting ylim for better spacing
label_y <- c(mean_dur_memb_seconds, mean_dur_casu_seconds) * 1.03
mean_dur_memb_time <- format(as.POSIXct(mean_dur_memb_seconds, origin = "1970-01-01"), format = "%M:%S")
mean_dur_casu_time <- format(as.POSIXct(mean_dur_casu_seconds, origin = "1970-01-01"), format = "%M:%S")
text(x = graph2, y = label_y, labels = c(mean_dur_memb_time, mean_dur_casu_time), pos = 3, offset = 0, cex = 1.1)

# Graph 3: Pie chart of the total number of trips by bike type
pie(totaltripsbybike, labels = paste(biketypes, round(100 * totaltripsbybike/sum(totaltripsbybike),1), "%", sep = " "), main = "Trips by bike type", col = c("yellow","blue","magenta"))

# Graph 4: Pie charts of client composition for the usage of each type of bike
# First we set up the layout for three pie charts side by side, then we fill it with the client composition for: 1)Classic bikes. 2)Electric bikes. 3)Docked bikes.
par(mfrow = c(1, 3))
pie(clas_clients, labels = paste(clienttypes, round(100 * clas_clients / sum(clas_clients), 1), "%", sep = " "), main = "Composition of Classic bike trips", col = c("green","red4"))
pie(elec_clients, labels = paste(clienttypes, round(100 * elec_clients / sum(elec_clients), 1), "%", sep = " "), main = "Composition of Electric bike trips", col = c("green","red4"))
pie(dock_clients, labels = paste(clienttypes, round(100 * dock_clients / sum(dock_clients), 1), "%", sep = " "), main = "Composition of Docked bike trips", col = c("green","red4"))

# Graph 5: Line plot of total trips across the year. We'll see a noticeable increase in service between May and October.
par(mfrow = c(1, 1))  # returning the layout to 1 chart per visualization
plot(1:12, monthtrips, type = "b", xlab = "Month", ylab = "Total Trips", main = "Total trips across the year", xaxt = "n", ylim = c(0, max(monthtrips) * 1.1))
axis(side = 1, at = 1:12, labels = months)

# Graph 6: Line plots for each bike type across the year.
plot(1:12, electricbymonth, type = "b", xlab = "Month", ylab = "Total Trips", main = "Total trips by bike type across the year",
         col = "green2", pch = 19, xaxt = "n", ylim = c(0, max(electricbymonth, classicbymonth, dockedbymonth)))
lines(1:12, classicbymonth, type = "b", col = "blue", pch = 19)
lines(1:12, dockedbymonth, type = "b", col = "magenta", pch = 19)
legend("topright", legend = c("Electric", "Classic", "Docked"),  col = c("green2", "blue", "magenta"), pch = 19, bty = "n")
axis(1, at = 1:12, labels = months)

# Graph 7: Bars plot comparing both types of client by the total number of trips they took each day of the week. Reordering columns so the graph starts with monday:
weekclients2 <- weekclients[, c(2:7, 1)]
barplot(weekclients2, main="Number of trips by client type for each day of the week", 
       xlab="Day of the week", ylab="Number of trips", col=c("green", "red4"), 
       legend = rownames(weekclients), args.legend = list(x = "topright"), names.arg = days[c(2:7, 1)], beside = TRUE)

# Graph 8: Bars plot comparing both types of client by the total number of trips they took each month
barplot(monthclients, main="Number of trips by client type for each month", 
       xlab="Month", ylab="Number of trips", col=c("green", "red4"), 
       legend = rownames(monthclients), args.legend = list(x = "topright"), names.arg = months, beside=TRUE)
