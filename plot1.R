if (!file.exists("power.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip",
                method="curl")
  unzip("power.zip")  
}
#read data from the text file 
data <- read.csv("household_power_consumption.txt", 
                 skip=66637,
                 nrows=2880,
                 sep=";",
                 na.strings = "?",
                 header=FALSE)
##format the date and time                 
names(data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
data$Time <- strptime(data$Time, format="%H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%y")

##create histogram 
png(filename="plot1.png", width=480, height=480)
hist(data$Global_active_power, 
     col="blue", 
     xlab="Global Active Power (kw)", 
     main="Global Active Power")
dev.off()