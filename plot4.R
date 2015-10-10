if (!file.exists("power.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip",
                method="curl")
  unzip("power.zip")  
}
##read the csv file
data <- read.csv("household_power_consumption.txt", 
                 skip=66637,
                 nrows=2880,
                 na.strings = "?",
                 sep=";",
                 header=FALSE,
                 )

##format the data to handle date and time while reading from the csv
names(data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")


##create 4 different plots
png(filename="plot4.png", width=480, height=480)
par(mfcol=c(2,2))
plot(data$DateTime, 
     data$Global_active_power, 
     type="l",
     xlab="",
     col="blue", 
     ylab="Global Active Power (kw)", 
     main="")

plot(data$DateTime, 
     data$Sub_metering_1, 
     type="l",
     col="black", 
     ylab="Energy sub metering",
     xlab="", 
         main="")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="green")
legend("topright", 
       lty=1,
        lwd=1, 
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$DateTime, 
     data$Voltage, 
     type="l",
     col="purple", 
     xlab="datetime", 
     ylab="Voltage", 
     main="")

plot(data$DateTime, 
     data$Global_reactive_power, 
     type="l",
     col="pink", 
     xlab="datetime", 
     ylab="Global_reactive_power", 
     main="")

dev.off()