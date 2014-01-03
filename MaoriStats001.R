### start  R script ##
## - Maori Stats, from New Zealand Censuses,  Peter J Keegan 4 Jan 2014 ####
#
## Section 1 #
#
library(ggplot2)
library(reshape2)
library(scales)
#
# Create vectors of NZ Census (Maori) Data with addition of my 2021 "guestimates"
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
d001a <- melt(d001, id.vars="Year")
names(d001a) <- c("Year", "Maori", "Population")
#
#  plot 1 & then improve it
#
# ggplot(d001a, aes(x=Year, y=Population, colour=Maori, group=Maori))+geom_line()+geom_point(size=4)
#
#  Plot 1 Final
#
plot01 <- ggplot(d001a, aes(x=Year, y=Population, colour=Maori, group=Maori)) + ggtitle("Fig. 1: NZ Census Data")
plot01 + geom_line() + geom_point(size=4) + scale_y_continuous(labels = comma) + expand_limits(y=0) + theme_bw(base_size = 19)
#
# End of Section 1
#
## Section 2 ##
#
# Create vectors of NZ Census Data, Maori speakers by age group by year (2001,2006,2013)
#
Year <- c(2001,2006,2013)
LessThan15 <- c(38673,35151,32961)
Age15to29 <- c(31479,31860,29232)
Age30to64 <- c(50967,53574,50910) 
Over64 <- c(9363,11031,12249)
#
# Combine to dataframe
#
d002 <- data.frame(Year, LessThan15, Age15to29, Age30to64, Over64)
#
rm(Year, LessThan15, Age15to29, Age30to64, Over64)  # Get rid of redundant vectors
#
# Convert data from wide to long format
#
d002a <- melt(d002, id.vars="Year")
names(d002a) <- c("Year", "AgeGroup", "Population")
#
#  Plot 2, 1st attempt
#
# ggplot(d002a, aes(x=Year, y=Population, fill=AgeGroup)) +geom_bar(position="dodge", stat="identity") + theme_bw(base_size = 16) + ggtitle("Census: Maori language speakers by Age Group")
#
#  change Plot 2 colours
#
plot02b <- ggplot(d002a, aes(x=Year, y=Population, fill=AgeGroup)) + geom_bar(position="dodge", stat="identity")
plot02b + scale_fill_brewer(palette="Set2") + theme_bw(base_size = 16) + ggtitle("Fig. 2: Census: Maori speakers by Age Group")
#
# End of Section 2
#
#
## Section 3 ##
# New Zealand Census Data, No. of Maori language speakers by Regions, 2001 to 2013 ##
#
d003 <- read.csv("~/MaoriStats01/MSpkReg01.csv") # get file local directory
#
d003a <- d003[c(2,9,6,3)]
#
d003b <- melt(d003a, id.vars="Region")
names(d003b) <- c("Region", "Year", "Population")
#
#  Plot 3, 1st basic,  then improve
#
# ggplot(d003b, aes(x=Region, y=Population, fill=Year)) +geom_bar(position="dodge", stat="identity") + theme_bw(base_size = 16) + ggtitle("Census: Maori language speakers by Region") + coord_flip()
#
#  Plot 3 - change plot colours
#
# plot03a <- ggplot(d003b, aes(x=Region, y=Population, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
# plot03a + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Census: Maori language speakers by Region")
#
#  Plot 3 - final plot - get order of regions right
#
plot03b <- ggplot(d003b, aes(x=Region, y=Population, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
plot03c <- plot03b + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Fig. 3: Census: Maori speakers by Region") 
plot03c + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury", "West Coast", "Marlborough", "Nelson", "Tasman", "Wellington", 
                                    "Manawatu-Wanganui", "Taranaki", "Hawke's Bay", "Gisborne", "Bay of Plenty", "Waikato", "Auckland", "Northland")) + theme(axis.title.y = element_blank())
#
# End of Section 3
#
#
## Section 4 ##
#
## New Zealand Census Data, % of Maori language speakers by Regions, 2001 to 2013 ##
#
#
d004a <- d003[c(2,11,8,5)]
#
d004b <- melt(d004a, id.vars="Region")
names(d004b) <- c("Region", "Year", "Percent")
#
#  Plot 4,  1st basic then improve
#
# ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity") + theme_bw(base_size = 16) + ggtitle("Census: % of Maori language speakers by Region") + coord_flip()
#
#  Plot 4,  - change plot colours
#
# plot04b <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
# plot04b + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Census: % Maori language speakers by Region")
#
#  Plot 4 - final plot
#
plot04c <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
plot4d <- plot04c + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Fig. 4: Census: % of Maori speakers by Region") 
plot4d + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury", "West Coast", "Marlborough", "Nelson", "Tasman", "Wellington", 
                                    "Manawatu-Wanganui", "Taranaki", "Hawke's Bay", "Gisborne", "Bay of Plenty", "Waikato", "Auckland", "Northland")) + theme(axis.title.y = element_blank())
#
#
# End of Section 4
#
#
# Section 5
#
# New Zealand Census Data, % of Maori language speakers by Regions vs. % of total regional pop. 2013 only ##
#
# Create vectors of NZ Census Data for 2013
#
Region <- c("Northland","Auckland","Waikato","Bay of Plenty","Gisborne","Hawke's Bay","Taranaki","Manawatu-Wanganui","Wellington","Tasman","Nelson","Marlborough","West Coast","Canterbury","Otago","Southland")
PerSpkr13 <- c(25.8,17.6,22.9,28.0,30.0,23.8,17.8,20.9,20.3,12.4,17.8,14.5,10.9,14.2,13.2,14.2)
PerPop13 <- c(29.6,10.1,20.7,25.7,45.1,22.9,16.6,19.6,12.4,7.3,9.0,11.0,9.9,7.8,7.1,12.4)
#
# Combine to dataframe
#
d005 <- data.frame(Region,PerSpkr13,PerPop13)
#
rm(Region,PerSpkr13,PerPop13)
#
#  Plot 5, basic then improve
#
# ggplot(d005, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point() + theme_bw(base_size = 16) + ggtitle("2013 Census: % Speakers by % of Region Pop.") 
#
#  Plot 5 - add labels, hide key
#
# plot5a <- ggplot(d005, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point() + theme_bw(base_size = 16) + ggtitle("2013 Census: Maori % Speakers by % of Region Pop.")
# plot5b <- plot5a + geom_text(aes(label=Region), hjust=1.1, vjust=.5, size=6) + xlim(5,40)+ ylim(5,50)
# plot5b + guides(fill=FALSE)
#
#  Plot 5, final
#
plot5c <- ggplot(d005, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point(colour="blue", size=4) + theme_bw(base_size = 16) + ggtitle("Fig. 5: 2013 Census: % Speakers by % Region Pop.")
plot5d <- plot5c + geom_text(aes(label=Region), hjust=1.1, vjust=.5, size=6) + xlim(5,30)+ ylim(7,46)
plot5d + guides(fill=FALSE)
#
# end of section 4
#
### end of R script ###