

LoadPackages <- function() {
    library(lubridate)
}


LoadAndSubsetData <- function() {
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
    
    idata$Date <- dmy(idata$Date)
    
    idata <- idata[idata$Date == ymd("2007-02-01") | idata$Date == ymd("2007-02-02"),]
    idata$Time <- hms(idata$Time)
    
    return(idata)
}

CreatePlot1 <- function(idata) {
    png(filename="plot1.png")
    
    with(idata, 
         hist(Global_active_power, 
              xlab="Global Active Power (kilowatts)", 
              main="Global Active Power",
              col="red"))

    dev.off()
    invisible(NA)
}
