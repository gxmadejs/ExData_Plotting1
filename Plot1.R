##This code creates "plot1" for assignment 1

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
##convert the relevant data into a useable type 
subpower$Global_active_power <- as.numeric(as.character(subpower$Global_active_power))

##create the histogram
hist(subpower$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")

## copy to a png file
dev.copy(png, file="plot1.png", width=480, height=480)
##Always close the connection!
dev.off()

##Let the user know the plot has been created!
cat("Plot1.png has been saved in", getwd())


