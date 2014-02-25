
## Loading data
data <- read.table("household_power_consumption.txt", header=TRUE, 
                   sep=";", dec=".", nrows=2075259, na.strings="?",
                   colClasses = c(rep("character", 2), rep("numeric", 7)))
## Checking data structure
#str(data)
#dim(data)

## Convert the Date variable to Date class
Date <- as.Date(data[,"Date"], "%d/%m/%Y")
data <- data.frame(Date, data[,-1])

## subsetting data (dates: 2007-02-01 and 2007-02-02)
sdata <- subset(data, Date >= as.Date("2007-02-01") &
                        Date <= as.Date("2007-02-02"))

## convert the Time variable to Time class
Time <- paste(sdata[,"Date"], sdata[,"Time"], sep=" ")
Time <- strptime(Time, "%Y-%m-%d %H:%M:%OS")
sdata <- data.frame(Time, sdata[,-2])


## Plot4
png("plot4.png", width=480, height =480, units = "px")
        par(mfcol = c(2, 2))
        ## Plot2
        with(sdata, plot(Time, Global_active_power, type="l", xlab="",
                         ylab="Global Active Power"))
        ## Plot3
        with(sdata, {
                plot(Time, Sub_metering_1, type="l", xlab="",
                     ylab="Energy sub metering")
                lines(Time, Sub_metering_2, col= "red")
                lines(Time, Sub_metering_3, col= "blue")
                legend("topright", col= c("black", "red", "blue"),
                       cex=0.8, lty="solid", yjust = 1, bty="n",
                       legend=c("Sub_metering_1", "Sub_metering_2",
                                "Sub_metering_3"))
        })
        with(sdata, plot(Time, Voltage, type="l", xlab="datetime"))
        with(sdata, plot(Time, Global_reactive_power, type="l", 
                         xlab="datetime"))
dev.off()

print(paste("Checking graphic in your working directory:", getwd()), sep=" ")