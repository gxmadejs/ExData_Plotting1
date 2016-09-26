##Check for data file. Download and unzip file if it is not present
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  f <- unzip(temp)
  unlink(temp)
}

##read the data file
globalpower <- read.table(f, header=T, sep=";")
##converts power$Date into a 'Date' type
globalpower$Date <- as.Date(globalpower$Date, format="%d/%m/%Y")
##subsets the relevant data
subpower <- globalpower[(globalpower$Date=="2007-02-01") | (globalpower$Date=="2007-02-02"),]

##convert the relevant data into a useable form
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))
subpower$Sub_metering_1 <- as.numeric(as.character(subpower$Sub_metering_1))
subpower$Sub_metering_2 <- as.numeric(as.character(subpower$Sub_metering_2))
subpower$Sub_metering_3 <- as.numeric(as.character(subpower$Sub_metering_3))
subpower <- transform(subpower, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

par(mfrow=c(2,2))

##Creates plot 1
plot(subpower$timestamp,subpower$Global_active_power, type="l", xlab="", ylab="Global Active Power")

##Creates plot 2
plot(subpower$timestamp,subpower$Voltage, type="l", xlab="datetime", ylab="Voltage")

##creates plot 3
plot(subpower$timestamp,subpower$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subpower$timestamp,subpower$Sub_metering_2,col="red")
lines(subpower$timestamp,subpower$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly

#3creates plot 4
plot(subpower$timestamp,subpower$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

##copy to png file
dev.copy(png, file="plot4.png", width=480, height=480)
##Close the connection
dev.off()

##Let the user know the plot has been created
cat("plot4.png has been saved in", getwd())