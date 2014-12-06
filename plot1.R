## Load the dataset 
## (it can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)
## Separator character is ;
## Missing values are coded as ?
dataset<-read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

## Subset only the dates 2007-02-01 and 2007-02-02
dates = c("1/2/2007","2/2/2007")
dataset<-subset(dataset, Date %in% dates)

## Convert the Date and Time variables to Date/Time classes in R
dataset$Time <- strptime(paste(dataset$Date, dataset$Time), "%d/%m/%Y %H:%M:%S")
dataset$Date <- as.Date(dataset$Date, "%d/%m/%Y")

## Prepare the PNG file
png(file="plot1.png", bg = "transparent", width=480, height=480)

## Plot the histogram of Global_active_power in red
hist(dataset$Global_active_power,col="red",main = "Global Active Power", xlab = "Global Active Power (kilowatts)") 

## Close device
dev.off()
