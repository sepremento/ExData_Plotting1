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

# Plotting the first graph
png("plot1.png", width = 480, height = 480)
with(data, hist(Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red"))
dev.off()
