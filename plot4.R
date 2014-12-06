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
png(file="plot4.png", width=480, height=480)

## In order to ensure that the day's labels appears in english, set the local to en_US
## First, save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")
## Then, set English locale
Sys.setlocale("LC_TIME", "en_US.UTF-8")

## Define the parameters of the graphic, with a layout of 2x2 plots
par(mfrow=c(2,2))

with(dataset, {
  # Plot the first plot
  plot(Time, Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

  # Plot the second plot
  plot(Time, Voltage,type="l",xlab="datetime") 

  # Plot the third plot
  plot(Time, Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",col="black")
  lines(Time, Sub_metering_2, col="red")
  lines(Time, Sub_metering_3, col="blue")
  legend("topright",
         col=c("black","red", "blue"), 
         bty = "n",                   # No border is set in the legend
         lwd=1, 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  )

  # Plot the fourth plot
  plot(Time, Global_reactive_power,type="l",xlab="datetime")
}) 

## Close device
dev.off()
