# Loading libraries
library(dplyr)
library(lubridate)

# First, let's unzip the .zip file:
filepath <- "./exdata_data_household_power_consumption.zip"
exdirpath <- "./househol_power_consumption"
unzip(filepath, exdirpath)

# Open the file, filter only the necessary strings and turn the 
# "Date" and "Time" columns into date type variables.
# We're skipping 46 days of December and January, each with 1440 rows and 1 extra row for variable names (toal 66637)
filepath <- "./household_power_consumption/household_power_consumption.txt"
cclasses <- c("Date", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
ccnames <- c("Date", "Time", "Global_active_power", "Global_reactive_power", 
	"Voltage", "Global_intensity", "Sub_metering_1","Sub_metering_2", "Sub_metering_3")
data <- tbl_df(read.table(filepath, sep=";", colClasses = cclasses, col.names = ccnames, skip = 66637, nrows = 2880))
data <- mutate(data, Time = hms(Time), Date = dmy(Date))

# Plotting the fourth graph
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(data$Global_active_power, type="l", xlab = "", ylab = "Global Active Power", xaxt = "n")
axis(side=1,at=c(0,1441,2881),labels=c('Thu','Fri','Sat'))
plot(data$Voltage, type="l", xlab="datetime", ylab="Voltage", xaxt = "n")
axis(side=1,at=c(0,1441,2881),labels=c('Thu','Fri','Sat'))
plot(data$Sub_metering_1, type="l", xlab = "", ylab = "Energy sub metering", xaxt = "n")
lines(data$Sub_metering_2, col="red")
lines(data$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black","red","blue"), lty=c(1,1,1), bty="n")
axis(side=1,at=c(0,1441,2881),labels=c('Thu','Fri','Sat'))
with(data, plot(Global_reactive_power, type="l", xlab = "datetime", xaxt = "n"))
axis(side=1,at=c(0,1441,2881),labels=c('Thu','Fri','Sat'))
dev.off()