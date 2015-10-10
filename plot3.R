if (!file.exists("power.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip",
                method="curl")
  unzip("power.zip")  
}

powercon <- read.csv("household_power_consumption.txt", 
                 skip=66637,
                 header=FALSE,
                 nrows=2880,
                 na.strings = "?",
                 sep=";")
names(powercon) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
data$DateTime <- as.POSIXct(paste(powercon$Date, powercon$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")

png(filename="plot3.png", width=480, height=480)
plot(data$DateTime, 
     data$Sub_metering_1, 
     col="blue",
     type="l",
     xlab="", 
     ylab="Energy sub metering", 
     main="")
lines(data$DateTime, data$Sub_metering_2, col="green")
lines(data$DateTime, data$Sub_metering_3, col="black")
legend("topright", 
       lty=1,
       lwd=1, 
               col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()