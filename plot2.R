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

#plot2
par(mfrow=c(1,1))
with(data, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab = ""))

#save as PNG
dev.copy(png, file = "plot2.png", height = 480, width = 480)
dev.off()