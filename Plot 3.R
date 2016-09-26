##Check for data file. Download and unzip file if it is not present
if(!file.exists("exdata-data-household_power_consumption.zip")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  f <- unzip(temp)
  unlink(temp)
}

##read the data file
globalpower <- read.table(f, header=T, sep=";")
##converts globalpower$Date into a 'Date' type
globalpower$Date <- as.Date(globalpower$Date, format="%d/%m/%Y")
##subsets the relevant data
subpower <- globalpower[(globalpower$Date=="2007-02-01") | (globalpower$Date=="2007-02-02"),]

##convert the relevant data into useable types
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))
subpower$Sub_metering_1 <- as.numeric(as.character(subpower$Sub_metering_1))
subpower$Sub_metering_2 <- as.numeric(as.character(subpower$Sub_metering_2))
subpower$Sub_metering_3 <- as.numeric(as.character(subpower$Sub_metering_3))
subpower <- transform(subpower, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

##Creates plot 3
plot(subpower$timestamp,subpower$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(subpower$timestamp,subpower$Sub_metering_2,col="red")
lines(subpower$timestamp,subpower$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1), cex = .65)

##Copy to a PNG file
dev.copy(png, file="plot3.png", width=480, height=480)
##Always close the connection!
dev.off()

##Let the user know plot3 has been created
cat("plot3.png has been saved in", getwd())