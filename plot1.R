ReadData <- function() {
	forNames <-read.table("household_power_consumption.txt", na.strings = "?", sep = ";", colClasses = c(rep("character", 2), rep("numeric", 7)), header = TRUE, comment.char = "", nrows = 10)
	data <- read.table("household_power_consumption.txt", na.strings = "?", sep = ";", colClasses = c(rep("character", 2), rep("numeric", 7)), header = TRUE, comment.char = "", skip = 66600, nrows = 3000)
	names(data) <- names(forNames)
	rm(forNames)
	data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
	data <- subset(data, data$Date == as.Date("2007-02-01", format = "%Y-%m-%d") | data$Date == as.Date("2007-02-02", format = "%Y-%m-%d"))
	data$Time <- strptime(data$Time, "%H:%M:%S")
	data
}

if (file.exists("household_power_consumption.txt")) {
	data <- ReadData()
	png("plot1.png", width = 480, height = 480)
	hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
	dev.off()
} else {
	print("Cannot locate the file household_power_consupmtion.txt in your working directory.")
	print("Please located the data and extract it there.")
}
