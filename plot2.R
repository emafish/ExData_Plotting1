## Thursday/Friday v.s. Global Active Power (kilowatts)

library(data.table)
library(dplyr)

plot2 <- function(){
  
  ## Read first three columns, only two dates(2007/2/1, 2007/2/2)
  
  DT <- fread("household_power_consumption.txt", 
              select = 1:3,
              nrows = 69516,
              na.strings = ",?,",
              data.table = T)
  
  datas <- tail(DT,2879)
  
  ## put Date and Time together
  ## paste(datas$Date, datas$Time)
  ## make a new column of time
  ## strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S")
  
  tidyData2 <- data.frame(tidyTime = strptime(paste(datas$Date, datas$Time), "%d/%m/%Y %H:%M:%S"), 
                     Global_active_power = as.numeric(datas$Global_active_power))
  
  ## Make the graph
  
  png("plot2.png", width = 480, height = 480)
  
  plot(tidyData2$tidyTime, tidyData2$Global_active_power, 
       type = "l", 
       ylab = "Global Active Power (kilowatts)", 
       xlab = "")
  
  dev.off()
}
