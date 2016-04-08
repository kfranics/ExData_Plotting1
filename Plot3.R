#install.packages("downloader")
library(downloader)

#download and unzip files
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")

electric <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

electric$Date <- strptime(electric$Date, "%d/%m/%Y")

electricset <- subset(electric, Date == '2007-02-01' | Date == '2007-02-02')

rm(electric)  #free up memory

electricset[,3:9] <- lapply(electricset[,3:9], as.numeric)
electricset$datetime <- as.POSIXlt(paste(electricset$Date, electricset$Time), format="%Y-%m-%d %H:%M:%S")

#Plot3 
with(electricset, plot(datetime, Sub_metering_1, type = 'n', ylab = "Energy sub metering", xlab = ''))
lines(electricset$datetime,electricset$Sub_metering_1, col = "black")
lines(electricset$datetime,electricset$Sub_metering_2, col = "red")
lines(electricset$datetime,electricset$Sub_metering_3, lty =1, col = "blue")

legend( "topright", cex = 1,  lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


png("Plot3.png", width=480, height=480)
with(electricset, plot(datetime, Sub_metering_1, type = 'n', ylab = "Energy sub metering", xlab = ''))
lines(electricset$datetime,electricset$Sub_metering_1, col = "black")
lines(electricset$datetime,electricset$Sub_metering_2, col = "red")
lines(electricset$datetime,electricset$Sub_metering_3, lty =1, col = "blue")

legend( "topright", cex = 1,  lty=1, col = c("black","red","blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
