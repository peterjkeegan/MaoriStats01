### start  R script 004 - Maori Stats 2013  Peter J Keegan  30 Dec 2013 ####
## New Zealand Census Data, No. of Maori language speakers by Regions, 2001 to 2013 ##
#
library(ggplot2)
library(reshape2)
library(RCurl)
#
# d004 <- read.csv("~/MaoriStats01/MSpkReg01.csv")
url <- ("https://raw.github.com/pjkeegan/MaoriStats01/MSpkReg01.csv")
d004 <- getURL(url)
d005 <- read.table(textConnection(d004), header=TRUE, sep=",", row.names=id, na.strings=" ")


##
### end of script ###


