library(ggplot2)
library(sqldf)
# This first line will likely take a few seconds. Be patient!
# Data has no NAs in it - colSums(is.na(NEI))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### ----------------------------------------------------
###   Data unique to this plot: Change in Emissions in Baltimore, MD due to Motor Vehicles
### ----------------------------------------------------
# Level 2 gives a good indicatioin of vehicle sources
SCCmv <- subset(SCC, grepl("Vehicle", SCCLevelTwo,ignore.case=T))
SCCmotorvehiclebaltimore<-sqldf("select a.year as Year, sum(a.Emissions) as SumEmissions, count(a.year) as Samples from NEI a inner join SCCmv b on a.SCC = b.SCC and a.fips='24510' group by a.year")

png("plot5.png",width=480,height=480)
g<-ggplot(SCCmotorvehiclebaltimore, aes(Year,SumEmissions))
g<-g + geom_line(color="steelblue",size=1)
g<-g + geom_point(color="steelblue",size=5)
g<-g + ggtitle("Change in Emissions in Baltimore, MD due to Motor Vehicles")
print(g)
dev.off()

