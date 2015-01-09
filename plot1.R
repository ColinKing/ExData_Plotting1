
# CODE TO READ DATA

readRawData <- function() {
  read.table("household_power_consumption.txt", header = TRUE, sep=";", colClass = c("character", "character", rep("numeric", 7)), na.strings = "?")
}

formatData <- function(rawdata = readRawData()) {
  datesOfInterest <- rawdata$Date == "1/2/2007" | rawdata$Date == "2/2/2007"
  data <- rawdata[datesOfInterest,]
  # Convert Dates and Times
  formatString <- "%d/%m/%Y %H:%M:%S"
  times <- strptime(paste(data$Date, data$Time), format = formatString)
  data$Time <- times
  data$Date <- NULL # Dates column is no longer necessary
  data
}

# CODE TO PLOT FIGURE AND PRINT TO PNG

plot1 <- function(data = formatData()) {
  # Set the file name
  png(filename = "plot1.png")
  
  # Draw Histogram of Global Active Power
  hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  
  # Close the device
  dev.off()
}