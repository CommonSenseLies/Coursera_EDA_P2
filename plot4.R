library(ggplot2)
library(sqldf)
# This first line will likely take a few seconds. Be patient!
# Data has no NAs in it - colSums(is.na(NEI))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### ----------------------------------------------------
###   Data unique to this plot: Change in Emissions in the US due to Coal sources
### ----------------------------------------------------
SCCcoal <- subset(SCC, grepl("Coal", ShortName,ignore.case=T))
coalData<-sqldf("select a.year as Year, sum(a.Emissions) as SumEmissions, count(a.Year) as Samples from NEI a inner join SCCcoal b on a.SCC = b.SCC group by a.year")

png("plot4.png",width=480,height=480)
g<-ggplot(coalData, aes(Year,SumEmissions))
g<-g + geom_line(color="steelblue", size=1)
g<-g + geom_point(color="red",size=5)
g<-g + ggtitle("Change in Emissions in the US due to Coal sources")
print(g)
dev.off()
