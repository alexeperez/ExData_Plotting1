
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


## Plot1
png("plot1.png", width=480, height =480, units = "px")
        par(mfcol = c(1, 1))
        with(sdata, hist(Global_active_power, main="Global Active Power",
                         xlab="Global Active Power (kilowatts)", col="red"))
dev.off()

print(paste("Checking graphic in your working directory:", getwd()), sep=" ")
