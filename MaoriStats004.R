### start  R script 004 - Maori Stats 2013  Peter J Keegan  31 Dec 2013 ####
## New Zealand Census Data, No. of Maori language speakers by Regions, 2001 to 2013 ##
#
library(ggplot2)
library(reshape2)
library(RCurl)
#
d004 <- read.csv("~/MaoriStats01/MSpkReg01.csv") # get file local directory
#
# Not sure why I can't access the CSV file directly from my GitHub !
# url <- ("https://raw.github.com/pjkeegan/MaoriStats01/MSpkReg01.csv")
# d004 <- getURL(url)
# d005 <- read.table(textConnection(d004), comment.char="", header=TRUE, sep=",", col.names=TRUE, row.names=NULL, na.strings=" ")
#
str(d004)
#
d005 <- d004[c(2,9,6,3)]
#
d006 <- melt(d005, id.vars="Region")
names(d006) <- c("Region", "Year", "Population")
#
#  1st plot basic then improve
#
ggplot(d006, aes(x=Region, y=Population, fill=Year)) +geom_bar(position="dodge", stat="identity") + theme_bw(base_size = 16) + ggtitle("Census: Māori language speakers by Region") + coord_flip()
#
#  2nd plot - change plot colours
#
plot06b <- ggplot(d006, aes(x=Region, y=Population, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
plot06b + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Census: Māori language speakers by Region")
#
#  3rd plot - final plot
#
plot06d <- ggplot(d006, aes(x=Region, y=Population, fill=Year)) +geom_bar(position="dodge", stat="identity") + coord_flip()
plot6da <- plot06c + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16) + ggtitle("Census: Māori language speakers by Region") 
plot6da + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury", "West Coast", "Marlborough", "Nelson", "Tasman", "Wellington", 
"Manawatu-Wanganui", "Taranaki", "Hawke's Bay", "Gisborne", "Bay of Plenty", "Waikato", "Auckland", "Northland")) + theme(axis.title.y = element_blank())



### end of script ###


