### start  R script 006 - Maori Stats 2013  Peter J Keegan  2 Jan 2014 ####
## New Zealand Census Data, % of Maori language speakers by Regions 2013 only ##
#
library(ggplot2)
#
# Create vectors of NZ Census Data for 2013
#
Region <- c("Northland","Auckland","Waikato","Bay of Plenty","Gisborne","Hawke's Bay","Taranaki","Manawatu-Wanganui","Wellington","Tasman","Nelson","Marlborough","West Coast","Canterbury","Otago","Southland")
PerSpkr13 <- c(25.8,17.6,22.9,28.0,30.0,23.8,17.8,20.9,20.3,12.4,17.8,14.5,10.9,14.2,13.2,14.2)
PerPop13 <- c(29.6,10.1,20.7,25.7,45.1,22.9,16.6,19.6,12.4,7.3,9.0,11.0,9.9,7.8,7.1,12.4)
#
# Combine to dataframe
#
d006 <- data.frame(Region,PerSpkr13,PerPop13)
#
#
#  1st plot basic then improve
#
ggplot(d006, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point() + theme_bw(base_size = 16) + ggtitle("2013 Census: % Speakers by % of Region Pop.") 
#
#  2nd plot - add labels, hide key
#
pq1 <- ggplot(d006, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point() + theme_bw(base_size = 16) + ggtitle("2013 Census: Māori % Speakers by % of Region Pop.")
pq2 <- pq1 + geom_text(aes(label=Region), hjust=1.1, vjust=.5, size=6) + xlim(5,40)+ ylim(5,50)
pq2 + guides(fill=FALSE)
#
# 3rd plot final
#
pr1 <- ggplot(d006, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point(colour="blue", size=4) + theme_bw(base_size = 18) + ggtitle("2013 Census: % Speakers by % of Region Pop.")
pr2 <- pr1 + geom_text(aes(label=Region), hjust=1.1, vjust=.5, size=6) + xlim(5,30)+ ylim(7,46)
pr2 + guides(fill=FALSE)
#
#
### end of script ###


