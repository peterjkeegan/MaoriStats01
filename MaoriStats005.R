### start  R script 005 - Maori Stats 2013  Peter J Keegan  1 Jan 2014 ####
## New Zealand Census Data, % of Maori language speakers by Regions, 2001 to 2013 ##
#
library(ggplot2)
library(reshape2)
# library(RCurl)  not really needed
#
d005 <- read.csv("~/MaoriStats01/MSpkReg01.csv") # get file local directory
#
# Not sure why I can't access the CSV file directly from my GitHub !
# url <- ("https://raw.github.com/pjkeegan/MaoriStats01/MSpkReg01.csv")
# d004 <- getURL(url)
# d005 <- read.table(textConnection(d004), comment.char="", header=TRUE, sep=",", col.names=TRUE, row.names=NULL, na.strings=" ")
#
str(d005)
#
d006 <- d005[c(2,11,8,5)]
#
d007 <- melt(d006, id.vars="Region")
names(d007) <- c("Region", "Year", "Percent")
#
#  1st plot basic then improve
#
ggplot(d007, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity") + theme_bw(base_size = 16) + ggtitle("Census: Māori language speakers by Region") + coord_flip()
#
#  2nd plot - change plot colours
#
plot07b <- ggplot(d007, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
plot07b + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Census: % Māori language speakers by Region")
#
#  3rd plot - final plot
#
plot07c <- ggplot(d007, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
plot7da <- plot07c + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Census: % Māori language speakers by Region") 
plot7da + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury", "West Coast", "Marlborough", "Nelson", "Tasman", "Wellington", 
"Manawatu-Wanganui", "Taranaki", "Hawke's Bay", "Gisborne", "Bay of Plenty", "Waikato", "Auckland", "Northland")) + theme(axis.title.y = element_blank())
#
#
#
### end of script ###


