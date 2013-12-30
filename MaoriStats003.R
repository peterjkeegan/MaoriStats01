### start  R script 003 - Maori Stats 2013  Peter J Keegan  30 Dec 2013 ####
## New Zealand Census Data, No. of Maori language speakers by 4 age Groups, 2001 to 2013 ##
#
library(ggplot2)
library(reshape2)
#
# Create vectors of NZ Census Data, Maori speakers by age group by year
#
Year <- c(2001,2006,2013)
LessThan15 <- c(38673,35151,32961)
Age15to29 <- c(31479,31860,29232)
Age30to64 <- c(50967,53574,50910) 
Over64 <- c(9363,11031,12249)
#
# Combine to dataframe
#
d003 <- data.frame(Year, LessThan15, Age15to29, Age30to64, Over64)
#
rm(Year, LessThan15, Age15to29, Age30to64, Over64)  # Get rid of redundant vectors
#
# Convert data from wide to long format
#
d004 <- melt(d003, id.vars="Year")
names(d004) <- c("Year", "AgeGroup", "Population")
#
#  plot
#
ggplot(d004, aes(x=Year, y=Population, fill=AgeGroup)) +geom_bar(position="dodge", stat="identity") + theme_bw(base_size = 16) + ggtitle("Census: Māori language speakers by Age Group")
#
#  change plot colours
#
plot04b <- ggplot(d004, aes(x=Year, y=Population, fill=AgeGroup)) +geom_bar(position="dodge", stat="identity")
plot04b + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Census: Māori language speakers by Age Group")
#
#
#
##
### end of script ###


