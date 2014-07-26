library(ggplot2)
library(sqldf)
# This first line will likely take a few seconds. Be patient!
# Data has no NAs in it - colSums(is.na(NEI))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### ----------------------------------------------------
###   Data unique to this plot
### ----------------------------------------------------
png("plot3.png",width=480,height=480)
NEISub<-sqldf("select year as Year,type as Type, sum(Emissions) as SumEmissions from NEI where fips = '24510' group by year,type") 
qplot(Year,SumEmissions,data=NEISub,color=Type,geom=c("point","path"),main="Total Emissions in Baltimore, Maryland by Type",size=I(1))
dev.off()