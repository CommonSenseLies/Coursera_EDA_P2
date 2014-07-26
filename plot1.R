# This first line will likely take a few seconds. Be patient!
# Data has no NAs in it - colSums(is.na(NEI))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### ----------------------------------------------------
###   Data unique to this plot
### ----------------------------------------------------
png("plot1.png",width=480,height=480)
sums<-tapply(NEI$Emissions,NEI$year,sum)
plot(x=names(sums),y=sums,type="b",lty=2,main="Total Emissions in the United States",xlab="Year",ylab="Total Emissions",col="blue")
dev.off()