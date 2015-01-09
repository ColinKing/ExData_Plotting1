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