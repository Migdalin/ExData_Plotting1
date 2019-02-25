

LoadPackages <- function() {
    library(lubridate)
}


LoadAndSubsetData4 <- function() {
    idata <- read.csv("household_power_consumption.txt", sep=";",
                      colClasses = c("character", 
                                     "character", 
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric",
                                     "numeric"), 
                      na.strings=c("?"))
    
    idata$Date <- as.Date(idata$Date, format="%d/%m/%Y")
    
    idata <- idata[idata$Date == ymd("2007-02-01") | idata$Date == ymd("2007-02-02"),]
    idata$Time <- strptime(idata$Time, format="%H:%M:%S")
    idata$DateAndTime <- with(idata, Time)
    year(idata$DateAndTime) <- year(idata$Date)
    month(idata$DateAndTime) <- month(idata$Date)
    day(idata$DateAndTime) <- day(idata$Date)
    
    return(idata)
}

CreatePlot4 <- function(idata) {
    png(filename="plot4.png")

    par(mfcol=c(2,2))
        
    with(idata, 
         plot(DateAndTime, 
              Global_active_power, 
              type="l", 
              xlab="", 
              ylab="Global Active Power (kilowats)"))
    
    with(idata, 
         plot(DateAndTime, 
              Sub_metering_1, 
              type="l", 
              xlab="", 
              ylab="Energy sub metering",
              col="black"))
    
    with(idata, lines(DateAndTime, Sub_metering_2, col="red"))
    with(idata, lines(DateAndTime, Sub_metering_3, col="blue"))
    legend("topright", 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"),
           lwd=c(2,2,2),
           bty="n")
    
    with(idata, plot(DateAndTime, 
                     Voltage,
                     type="l",
                     xlab="datetime",
                     ylab="Voltage",
                     col="black"))
    
    with(idata, plot(DateAndTime, 
                     Global_reactive_power,
                     type="l",
                     xlab="datetime",
                     ylab="Global_reactive_power"))
    
    
    dev.off()
    invisible(NA)
}
