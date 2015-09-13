## Thu/Fri v.s. Energy sub metering

library(data.table)
library(dplyr)

plot3 <- function(){
  
  ## Read first three columns, only two dates(2007/2/1, 2007/2/2)
  
  DT <- fread("household_power_consumption.txt", 
              drop = 3:6,
              nrows = 69516,
              na.strings = ",?,",
              data.table = T)
  
  datas <- tail(DT,2879)
  
  ## put Date and Time together
  ## paste(datas$Date, datas$Time)
  ## make a new column of time
  ## strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S")
  
  tidyData3 <- data.frame(tidyTime = strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S"), 
                          Sub_metering_1 = as.integer(datas$Sub_metering_1),
                          Sub_metering_2 = as.integer(datas$Sub_metering_2),
                          Sub_metering_3 = as.integer(datas$Sub_metering_3))
  
  ## Make the graph
  
  png("plot3.png", width = 480, height = 480)
  
  plot(tidyData3$tidyTime, tidyData3$Sub_metering_1, 
       type = "l", 
       ylab = "Energy sub metering", 
       xlab = "")
  
  lines(tidyData3$tidyTime, tidyData3$Sub_metering_2,
        col = "red")
  
  lines(tidyData3$tidyTime, tidyData3$Sub_metering_3, 
        col = "blue")
  
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lty = c(1,1))
  
  dev.off()
}