library(ggplot2)
library(sqldf)
# This first line will likely take a few seconds. Be patient!
# Data has no NAs in it - colSums(is.na(NEI))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


### ----------------------------------------------------
###   Data unique to this plot: Change in Emissions in Baltimore, MD vs. Los Angeles, CA due to Motor Vehicles
### ----------------------------------------------------
SCCmv <- subset(SCC, grepl("Vehicle", SCCLevelTwo,ignore.case=T))
SCCmotorvehiclebaltimorela<-sqldf("select a.year as Year, a.fips as City, sum(a.Emissions) as SumEmissions, count(a.year) as NumSources from NEI a inner join SCCmv b on a.SCC = b.SCC and a.fips in ('24510','06037') group by a.year,a.fips")
SCCmotorvehiclebaltimorela$City <- factor(SCCmotorvehiclebaltimorela$City, labels = c("LA", "Balitmore"))

png("plot6.png",width=480,height=480)
g<-ggplot(SCCmotorvehiclebaltimorela, aes(Year,SumEmissions,colour=City))
g<-g + geom_line(aes(group=City),size=1)
g<-g + geom_hline(aes(yintercept=SCCmotorvehiclebaltimorela[1,3]),linetype=3,size=1)
g<-g + geom_hline(aes(yintercept=SCCmotorvehiclebaltimorela[7,3]),linetype=3,size=1)
g<-g + geom_hline(aes(yintercept=SCCmotorvehiclebaltimorela[2,3]),linetype=5,size=1)
g<-g + geom_hline(aes(yintercept=SCCmotorvehiclebaltimorela[8,3]),linetype=5,size=1)
g<-g + geom_text(aes(2004, (SCCmotorvehiclebaltimorela[7,3] + SCCmotorvehiclebaltimorela[1,3])/2, label=as.character(as.integer(SCCmotorvehiclebaltimorela[7,3] - SCCmotorvehiclebaltimorela[1,3]))),color="black")
g<-g + geom_text(aes(2004, (SCCmotorvehiclebaltimorela[2,3] + SCCmotorvehiclebaltimorela[8,3])/2, label=as.character(as.integer(SCCmotorvehiclebaltimorela[8,3] - SCCmotorvehiclebaltimorela[2,3]))),color="black")
g<-g + geom_point(size=5)
g<-g + ggtitle("Change in Motor Vehicle Emissions in Baltimore vs Los Angeles")

print(g)
dev.off()
