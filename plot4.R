## datetime v.s. Global Active Power
##                Voltage
##                Energy sub metering
##                Global_reactibe_power

library(data.table)
library(dplyr)

plot4 <- function(){
  
  ## Read first three columns, only two dates(2007/2/1, 2007/2/2)
  
  DT <- fread("household_power_consumption.txt", 
              drop = 6,
              nrows = 69516,
              na.strings = ",?,",
              data.table = T)
  
  datas <- tail(DT,2879)
  
  ## put Date and Time together
  ## paste(datas$Date, datas$Time)
  ## make a new column of time
  ## strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S")
  
  tidyData4 <- data.frame(tidyTime = strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S"),
                          Global_active_power = as.numeric(datas$Global_active_power),
                          Global_reactive_power = as.numeric(datas$Global_reactive_power),
                          Voltage = as.numeric(datas$Voltage),
                          Sub_metering_1 = as.integer(datas$Sub_metering_1),
                          Sub_metering_2 = as.integer(datas$Sub_metering_2),
                          Sub_metering_3 = as.integer(datas$Sub_metering_3))
  
  ## Make the graph
  
  png("plot4.png", width = 480, height = 480)
  
  par(mfrow = c(2,2))
  
  plot(tidyData4$tidyTime, tidyData4$Global_active_power, 
       type = "l", 
       ylab = "Global Active Power (kilowatts)", 
       xlab = "")
  
  plot(tidyData4$tidyTime, tidyData4$Voltage, 
       type = "l", 
       ylab = "Voltage", 
       xlab = "datetime")
  
  plot(tidyData4$tidyTime, tidyData4$Sub_metering_1, 
       type = "l", 
       ylab = "Energy sub metering", 
       xlab = "")
  
  lines(tidyData4$tidyTime, tidyData4$Sub_metering_2,
        col = "red")
  
  lines(tidyData4$tidyTime, tidyData4$Sub_metering_3, 
        col = "blue")
  
  legend("topright", 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         col = c("black", "red", "blue"), 
         lty = c(1,1))
  
  plot(tidyData4$tidyTime, tidyData4$Global_reactive_power, 
       type = "l", 
       ylab = "Global_reactive_power", 
       xlab = "datetime")
  
  dev.off()
}