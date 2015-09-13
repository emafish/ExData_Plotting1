## Global Active Power
## Global Active Power (kilowatts) v.s. Frequency

## Read data from 2007-02-01 and 2007-02-02
library(data.table)
library(dplyr)

## Get the right dates out
## total of 2879 observations from 66638 to 69516

GetTheRightLines <- function() {
  DT <- fread("household_power_consumption.txt", select=c("Date"))
  for (i in 1:nrow(DT)){
    dates <- as.Date(DT$Date[i], "%d/%m/%Y")
    if (dates == "2007-02-01") {
      x <- i
      break()
    }
  }
  for (i in 1:nrow(DT)){
    dates <- as.Date(DT$Date[i], "%d/%m/%Y")
    if (dates == "2007-02-03") {
      y <- i - 1
      break()
    }
  }
  print(x)
  print(y)
  z <- y - x
  print(z)
}

plot1 <- function(){
  DT <- fread("household_power_consumption.txt", 
              select = 1:3,
              nrows = 69516,
              na.strings = ",?,",
              data.table = T)

  Datas <- tail(DT,2879)

  ## Select Global_active_power only and make it numeric


  data1 <- sapply(Datas$Global_active_power, as.numeric)
  
  ## Make the histogram
  
  png("plot1.png", width = 480, height = 480)
  
  hist(data1, freq = T, 
       main = "Global Active Power", 
       col = 2, 
       xlab = "Global Activ Power (kilowatts)", 
       ylab = "Frequency")
  
  dev.off()
}
