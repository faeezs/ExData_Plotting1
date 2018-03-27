rm(list = ls())
## Downloading the data
if (!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "./data/Dataset.zip")
unzip("./data/Dataset.zip", exdir = "./data/")

## Read data from downloaded file
data = read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors=FALSE, dec=".")

#convert into date class
data$Date <- as.Date(data$Date, "%d/%m/%Y")
#subset data
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
#convert into DateTime POSIXt
data$DateTime <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")

#plot4
par(mfrow = c(2, 2), mar = c(4, 4, 1, 1))
with(data, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))
with(data, plot(DateTime, Voltage, type = "l", xlab = "datetime"))
with(data, plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = ""))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), xjust = 1, lty=1, lwd=2, col=c("black", "red", "blue"), bty = "n")
with(data, plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime"))

#save as PNG
dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()