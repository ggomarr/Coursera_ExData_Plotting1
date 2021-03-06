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
png("plot3.png",width = 480, height = 480)
# Make fonts smaller (finally, not necessary)
# par(cex=0.7)
# Draw plot
plot(mydata$Time,mydata$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(mydata$Time,mydata$Sub_metering_1)
lines(mydata$Time,mydata$Sub_metering_2,col="red")
lines(mydata$Time,mydata$Sub_metering_3,col="blue")
# Add legend
legend("topright",lty=1,col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Write png file
dev.off()