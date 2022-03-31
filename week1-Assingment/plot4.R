# set working directory
setwd("/Users/serilee/Dropbox/내 PC (DESKTOP-B7IJKD9)/Desktop/Personal/Coursera/04_Exploratory Data Analysis/week1/assignment")

# read data amd save it in House_Eng variable
House_Eng = read.table("household_power_consumption.txt", sep=";", header = T)
# check each column characteristic
str(House_Eng)

# select from 1/2/2007 to 2/2/2007 and save it to House_Eng_Feb variable
House_Eng_Feb = subset(House_Eng, Date == "1/2/2007" | Date == "2/2/2007")
# bind Date and Time column and save it in new variable, Date_time
Date_time = paste(House_Eng_Feb$Date, House_Eng_Feb$Time, sep = " ")
# convert the Date and time columns from character to Date and time
Date_time = strptime(Date_time, "%d/%m/%Y %H:%M:%S")
# add Date_time to previous data frame
House_Eng_D = data.frame(Date_time, House_Eng_Feb)
str(House_Eng_D)

# before convert character to  numeric, to protect decimal point number, set digit value
options(digits = 10)
# convert character to  numeric
House_Eng_D$Global_active_power = as.numeric(House_Eng_D$Global_active_power)
House_Eng_D$Global_reactive_power = as.numeric(House_Eng_D$Global_reactive_power)
House_Eng_D$Voltage = as.numeric(House_Eng_D$Voltage)
House_Eng_D$Global_intensity = as.numeric(House_Eng_D$Global_intensity)
House_Eng_D$Sub_metering_1 = as.numeric(House_Eng_D$Sub_metering_1)
House_Eng_D$Sub_metering_2 = as.numeric(House_Eng_D$Sub_metering_2)
House_Eng_D$Sub_metering_3 = as.numeric(House_Eng_D$Sub_metering_3)
# check if converting is right
str(House_Eng_D)

# set plot4.png file
png("plot4.png", width=480, height=480)
#set 2X2 windows
par(mfrow=c(2,2))
# arrange 1st plot
with(House_Eng_D, plot(Global_active_power ~ Date_time, type="l", xlab="", ylab="Global active power"))
# arrange 2nd plot
with(House_Eng_D, plot(Voltage ~ Date_time, type="l", xlab="datetime", ylab="Voltage"))
# arrange 3rd plot
with(House_Eng_D, {plot(Sub_metering_1 ~ Date_time, col="black", type="l", xlab="", ylab="Energy sub metering")
lines(Sub_metering_2 ~ Date_time, col="red")
lines(Sub_metering_3 ~ Date_time, col="blue")})
legend("topright", lty=1, lwd=1, col = c("black","blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# arrange 4st plot
with(House_Eng_D, plot(Global_reactive_power ~ Date_time, type="l", xlab="datetime", ylab="Global_reactive_power"))
#close graphic device
dev.off()
