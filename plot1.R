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

#convert into date and time class
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")

#subset data
data <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

#construct histogram
par(mfrow=c(1,1))
hist(data$Global_active_power, main = "Global Active Power",xlab = "Global Active Power (kilowatts)", col = "red")

#save as PNG
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
