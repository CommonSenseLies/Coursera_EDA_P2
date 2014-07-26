# This first line will likely take a few seconds. Be patient!
# Data has no NAs in it - colSums(is.na(NEI))
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEIT <- transform(NEI,logEmissions= log(Emissions + 1))
 
model <- lm(logEmissions~year, NEIT)
means<-tapply(NEIT$logEmissions,NEIT$year,median)
sums<-tapply(NEIT$logEmissions,NEIT$year,sum)
counts<-tapply(NEIT$logEmissions,NEIT$year,count)

plot(NEIT$year,NEIT$logEmissions,main="Yearly Emissions",xlab="Year",ylab="Log(Emissions+1)",col="blue")
#boxplot(logEmissions ~ year,NEIT,outline=T,main="Yearly Emissions",xlab="year",ylab="Log(Emissions+1)",col="blue")
abline(model,lwd=2,col="green")
points(as.numeric(names(means)),means,pch=18,cex=2,col="red")
legend("topright",lty=c(0,1,0), lwd=2,seg.len = 3,pch=c(1,NA,18),col=c("blue","green","red"),legend=c("Points","Regression","Medians"))
