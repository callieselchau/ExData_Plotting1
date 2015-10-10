

if (!file.exists("power.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="power.zip",
                method="curl")
  unzip("power.zip")  
}
##read the csv file and place in a table
powercon <- read.csv("household_power_consumption.txt", 
                 skip=99999,
                 nrows=2880,
                 na.strings = "?",
                 header=FALSE,
                 sep=";")
names(powercon) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))

##format the date and time into the correct format
powercon$DateTime <- as.POSIXct(paste(powercon$Date, powercon$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")

##take the data read from the file above and put into graph
png(filename="plot2.png", width=480, height=480)
plot(powercon$DateTime, 
     powercon$Global_active_power, 
     col="purple",
     type="l",
     xlab="", 
     ylab="Global Power (KW)", 
     main="")
dev.off()