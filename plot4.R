# Step 1 (getting the dataset):
temp <- tempfile()
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, temp)
dataset <- read.table(unz(temp,"household_power_consumption.txt"), header=T, na.strings = "?", sep=";")

# Step 2 (subsetting our dataset):
data <- subset(dataset, Date == "1/2/2007" | Date == "2/2/2007" )

# Step 3 (converting date and time):
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- strptime(data$DateTime, format = "%d/%m/%Y %H:%M:%S")

# Step 4 (creating a plot):
par(mfrow = c(2,2), mar = c(4,4,2,1))
with(data, {
    plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power(kilowatts)", xlab = "" )
    plot(DateTime, Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(DateTime, Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
    lines(DateTime, Sub_metering_2, col = "red")
    lines(DateTime, Sub_metering_3, col = "blue")
    legend("topright", bty = "n", lty = 1, lwd = 2, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3" ))
    plot(DateTime, Global_reactive_power, type = "l", xlab = "datetime")
})
dev.copy(png, "plot4.png", height=480, width=480)
dev.off()
