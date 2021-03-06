library(dplyr)
library(lubridate)
library(data.table)

#reading data table
datafile <- "./data/household_power_consumption.txt"
data <-read.table(datafile, na.strings="?", sep=";", stringsAsFactors = FALSE)
#reading jan and feb data only
power <- read.table(datafile, header=T, sep=";")
power$Date <- as.Date(power$Date, format="%d/%m/%Y")
janfeb <- power[(power$Date=="2007-02-01") | (power$Date=="2007-02-02"),]
janfeb$Global_active_power <- as.numeric(as.character(janfeb$Global_active_power))
janfeb$Global_reactive_power <- as.numeric(as.character(janfeb$Global_reactive_power))
janfeb$Voltage <- as.numeric(as.character(janfeb$Voltage))
janfeb <- transform(janfeb, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
janfeb$Sub_metering_1 <- as.numeric(as.character(janfeb$Sub_metering_1))
janfeb$Sub_metering_2 <- as.numeric(as.character(janfeb$Sub_metering_2))
janfeb$Sub_metering_3 <- as.numeric(as.character(janfeb$Sub_metering_3))

#drawing plot2
Plot2 <- plot(janfeb$timestamp, janfeb$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts")
dev.copy(png, file="Plot2.png", width=480, height=480)
dev.off()
