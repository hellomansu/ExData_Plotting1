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

#Get the Global_active_power, Date, Time & plot it
#--------------------------------------------------
str(filterdData)
#looks like its a char, convert it to numeric type.
filterdData$Global_active_power <- as.numeric(filterdData$Global_active_power)

#prepare a calc field by combining both date, time
filterdData$datetime <- strptime(paste(filterdData$Date, filterdData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

#prepare png device & plot
png("plot2.png", width = 480, height = 480)
with(filterdData, plot(datetime, Global_active_power, type="l", xlab="",  ylab = "Global Active Power (kilowatts)"))
dev.off()
