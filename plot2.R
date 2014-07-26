# This first line will likely take a few seconds. Be patient!
# Data has no NAs in it - colSums(is.na(NEI))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### ----------------------------------------------------
###   Data unique to this plot
### ----------------------------------------------------
png("plot2.png",width=480,height=480)
NEISub<-subset(NEI,fips == "24510")
sums<-tapply(NEISub$Emissions,NEISub$year,sum)
plot(x=names(sums),y=sums,type="b",lty=2,main="Yearly Emissions in Baltimore City, Maryland",xlab="Year",ylab="Total Emissions",col="red")
dev.off()