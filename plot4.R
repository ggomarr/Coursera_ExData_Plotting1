# Get headers from file as dataframe
headers<-read.table("household_power_consumption.txt",sep=";",nrows=1)
# Turn headers into a vector
headers<-as.vector(t(headers))
# Read the data from 1 Feb 2007 to (end of) 2 Feb 2007
mydata<-read.table("household_power_consumption.txt",
                   sep=";",col.names=headers,na.strings="?",
                   skip=36+6*60+15*24*60+31*24*60+1,nrows=2*24*60+1)
# Reformat Time into proper time from string
mydata$Time<-strptime(paste(mydata$Date,mydata$Time),"%d/%m/%Y %H:%M:%S",tz="GMT")
# Reformat Dime into proper date from string
mydata$Date<-as.Date(mydata$Date)
# Open a png file for the plot
png("plot4.png",width = 480, height = 480)
# Set up 2x2 multiplot
par(mfrow=c(2,2))
# Make fonts smaller and reduce margins (finally, not necessary)
# par(cex=0.7,oma=c(0.5, 0.5, 0.5, 0.5))
# Draw plot 1.1
plot(mydata$Time,mydata$Global_active_power,type="n",xlab="",ylab="Global Active Power")
lines(mydata$Time,mydata$Global_active_power)
# Draw plot 1.2
plot(mydata$Time,mydata$Voltage,type="n",xlab="datetime",ylab="Voltage")
lines(mydata$Time,mydata$Voltage)
# Draw plot 2.1
plot(mydata$Time,mydata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(mydata$Time,mydata$Sub_metering_1)
lines(mydata$Time,mydata$Sub_metering_2,col="red")
lines(mydata$Time,mydata$Sub_metering_3,col="blue")
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
# Draw plot 2.2
plot(mydata$Time,mydata$Global_reactive_power,type="n",xlab="datetime",ylab="Global_reactive_power")
lines(mydata$Time,mydata$Global_reactive_power)
# Write png file
dev.off()