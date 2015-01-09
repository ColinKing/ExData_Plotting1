
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

plot4 <- function(data = formatData()) {
  # Set file name
  png(filename = "plot4.png")
  
  # Set up the 2x2 matrix for the graphs
  par(mfcol = c(2, 2))
  
  # Draw the Global Active Power vs. Time Graph
  plot(data$Time, data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
  lines(data$Time, data$Global_active_power)
  
  # Draw the Sub Metering vs. Time Graph
  plot(data$Time, data$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
  lines(data$Time, data$Sub_metering_1, col = "black")
  lines(data$Time, data$Sub_metering_2, col = "red")
  lines(data$Time, data$Sub_metering_3, col = "blue")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 2, bty = "n", col = c("black", "red", "blue"))
  
  # Draw the Voltage vs. Time Graph
  plot(data$Time, data$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
  lines(data$Time, data$Voltage)
  
  # Draw the Global Reactive Power vs. Time Graph
  plot(data$Time, data$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
  lines(data$Time, data$Global_reactive_power)
  
  # Close the device
  dev.off()
}