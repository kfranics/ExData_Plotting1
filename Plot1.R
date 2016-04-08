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

#Plot1
hist(electricset$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "red", freq = TRUE, breaks =12)

png("Plot1.png", width=480, height=480)
hist(electricset$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power", col = "red", freq = TRUE, breaks =12)
dev.off()

