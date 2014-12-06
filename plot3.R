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
png(file="plot3.png", width=480, height=480)

## In order to ensure that the day's labels appears in english, set the local to en_US
## First, save current system's locale
locale <- Sys.getlocale(category = "LC_TIME")
## Then, set English locale
Sys.setlocale("LC_TIME", "en_US.UTF-8")

## Plot the plot2
with(dataset, {
  plot(Time, Sub_metering_1,      # Create the plot  
       type="l",                  # Graph type is line
       ylab="Energy sub metering",# Set the y-axis label
       xlab="",                   # Left x-axis blank
       col="black"                # Set color line to black
  )
  
  lines(Time, Sub_metering_2, col="red")  # Add a line to the plot with a red line
  lines(Time, Sub_metering_3, col="blue") # Add a line to the plot with a blue line
  
  legend("topright",                      # Create a legend in the topright position
         col=c("black","red", "blue"),    # Define the three colors of the legend
         lwd=1,                           # Define the line width
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") # Define the labels
  )
})

## Finally, restore system's original locale
Sys.setlocale("LC_TIME", locale)

## Close device
dev.off()