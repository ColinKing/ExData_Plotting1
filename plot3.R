
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

plot3 <- function(data = formatData()) {
  # Set the file name
  png(filename = "plot3.png")
  
  # Graph the Sub Metering vs. Time Graphs
  plot(data$Time, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(data$Time, data$Sub_metering_1, col = "black")
  lines(data$Time, data$Sub_metering_2, col = "red")
  lines(data$Time, data$Sub_metering_3, col = "blue")
  # Add a legend with colored lines
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 2, col = c("black", "red", "blue"))
  
  # Close the device
  dev.off()
}