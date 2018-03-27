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

#plot3
par(mfrow=c(1,1))
with(data, plot(DateTime, Sub_metering_1, type="l", ylab="Energy Submetering", xlab=""))
with(data, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(data, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#save as PNG
dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()