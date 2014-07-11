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
with(data, plot(DateTime, Global_active_power, type = "l", xlab ="", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, "plot2.png", height=480, width=480)
dev.off()
