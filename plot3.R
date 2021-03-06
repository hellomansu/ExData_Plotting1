#Placed the file in to my working directory. Assign the name to a variable.
file.name <- "household_power_consumption.txt"
#read the file into a data frame
data <- read.table(file = file.name, header = TRUE, sep = ";", stringsAsFactors = FALSE, dec = ".")
#review the structure of the data frame
str(data)

#load the dplyr library to filter out the unnecessary rows.
library(dplyr)
#Filter the data , where date in "1/2/2007","2/2/2007" using dplyr's filter function
filterdData <- data %>% filter( Date %in% c("1/2/2007","2/2/2007") )
#View sample rows
head(filterdData)

#Get the Global_active_power, Date, Time, sub metering1, 2, 3 & plot it
#-----------------------------------------------------------------------
str(filterdData)
#looks like its a char, convert it to numeric type.
filterdData$Global_active_power <- as.numeric(filterdData$Global_active_power)
filterdData$Sub_metering_1 <- as.numeric(filterdData$Sub_metering_1)
filterdData$Sub_metering_2 <- as.numeric(filterdData$Sub_metering_2)
filterdData$Sub_metering_3 <- as.numeric(filterdData$Sub_metering_3)

#prepare a calc field by combining both date, time
filterdData$datetime <- strptime(paste(filterdData$Date, filterdData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#prepare png device & plot
png("plot3.png")
with(filterdData, plot(datetime, Sub_metering_1, type="l", xlab="",  ylab = "Energy Submetering"))
with(filterdData, lines(datetime, Sub_metering_2, type="l", col = "red"))
with(filterdData, lines(datetime, Sub_metering_3, type="l", col = "blue"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=1.5, col=c("black", "red", "blue"))

dev.off()
