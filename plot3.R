library(data.table)
#   
#  james.primrose 11.10.2018                   '_' 
#  reads in some energy data set              {0,0} -w00t!  
#  and barfs out a heap of plots              (| (\
#                                             -"-"-  
#  PLOT3.R
#
# fread our dataset and cast to data table
hpc <- fread("household_power_consumption.txt",head=TRUE,sep=";", na.strings="?")
hpc <- data.table(hpc)

# Cast hpc$Date to date and subset 
# 2007-02-01 and 2007-02-02
hpc$Dt <- as.Date(hpc$Date,'%d/%m/%Y')
hpc <- subset(hpc,hpc$Dt==as.Date('2007-02-01','%Y-%m-%d') | hpc$Dt==as.Date('2007-02-02','%Y-%m-%d'))
hpc$str_date <- paste(hpc$Date, hpc$Time)

# cast to numeric
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
hpc$Global_reactive_power <- as.numeric(hpc$Global_reactive_power)
hpc$Voltage <- as.numeric(hpc$Voltage)
hpc$Global_intensity <- as.numeric(hpc$Global_intensity)
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3)

# plot 3
png("plot3.png",width=480,height=480)
plot(strptime(hpc$str_date, "%d/%m/%Y %H:%M:%S"),hpc$Sub_metering_1,cex=0,xlab="",ylab="Energy sub metering")
lines(strptime(hpc$str_date, "%d/%m/%Y %H:%M:%S"),hpc$Sub_metering_1)
lines(strptime(hpc$str_date, "%d/%m/%Y %H:%M:%S"),hpc$Sub_metering_2,col="red")
lines(strptime(hpc$str_date, "%d/%m/%Y %H:%M:%S"),hpc$Sub_metering_3,col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"),
       text.col = "black", lty= c(1,1,1),
       merge = TRUE,bg="white")
dev.off()








