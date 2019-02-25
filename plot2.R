

LoadPackages <- function() {
    library(lubridate)
}


LoadAndSubsetData2 <- function() {
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

CreatePlot2 <- function(idata) {
    png(filename="plot2.png")
    
    with(idata, 
         plot(DateAndTime, 
              Global_active_power, 
              type="l", 
              xlab="", 
              ylab="Global Active Power (kilowats)"))
    
    dev.off()
    invisible(NA)
}
