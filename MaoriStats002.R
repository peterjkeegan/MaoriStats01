### start  R script - Maori Stats 2013  Peter J Keegan  29 Dec 2013 ####
#
library(ggplot2)
library(reshape2)
library(scales)
#
# Create vectors of NZ Census Data with addition of my 2021 "guestimates"
#
Year <- c(1991,1996,2001,2006,2013,2021)
Ethnicity <- c(434847,523371,526281,565329,598605,610000)
Descent <- c(511278,579714,604110,643977,668724,683000)
Speakers <- c(NA, NA, 130485, 131601,125352,116000) # no language question pre 2001 Census
#
# Combine to dataframe
#
d001 <- data.frame(Year, Descent, Ethnicity, Speakers)
#
rm(Descent,Ethnicity, Speakers, Year)  # Get rid of redundant vectors
#
# Convert data from wide to long format
#
d002 <- melt(d001, id.vars="Year")
names(d002) <- c("Year", "Māori", "Population")
#
#  plot
#
ggplot(d002, aes(x=Year, y=Population, colour=Māori, group=Māori))+geom_line()+geom_point(size=4)
#
plot02 <- ggplot(d002, aes(x=Year, y=Population, colour=Māori, group=Māori)) + ggtitle("NZ Census Data")
plot02 +geom_line() +geom_point(size=4) + scale_y_continuous(labels = comma) + expand_limits(y=0) + theme_bw(base_size = 19)
#
### end of script ###


