## start  R script ##
# Maori Language Stats, from New Zealand Censuses, Peter J Keegan updated 20 Dec 2014 #
#
# Section 1
#
library(ggplot2)
library(reshape2)
library(scales)
#
# Create vectors of NZ Census (Maori) Data, with addition of my 2021 "guestimates"
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
#  plot 1 1st attempt
#
# ggplot(d001a, aes(x=Year, y=Population, colour=Maori, group=Maori)) + geom_line() + geom_point(size=4)
#
#  plot 1 Final
#
plot01a <- ggplot(d001a, aes(x=Year, y=Population, colour=Maori, group=Maori))
plot01b <- plot01a + ggtitle("Figure 1: New Zealand Census Data")
plot01c <- plot01b + geom_line() + geom_point(size=4) + scale_y_continuous(labels = comma)
plot01d <- plot01c + expand_limits(y=0) + theme_bw(base_size = 20)
plot01d + theme (plot.title = element_text(size=20))
#
rm(plot01a, plot01b, plot1c)
#
#
# Section 2 #
#
# Create vectors of NZ Census Data, Maori speakers by age group by year (2001, 2006, 2013)
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
# plot 2, 1st attempt
#
# plot02a <- ggplot(d002a, aes(x=Year, y=Population, fill=AgeGroup)) + geom_bar(position="dodge", stat="identity")
# plot02a + theme_bw(base_size = 20) + ggtitle("Census: Maori language speakers by 4 Age Groups")
#
# change plot 2 colours
#
plot02a <- ggplot(d002a, aes(x=Year, y=Population, fill=AgeGroup)) + geom_bar(position="dodge", stat="identity")
plot02b <- plot02a + scale_fill_brewer(palette="Set2") + theme_bw(base_size = 20)
plot02c <- plot02b + ggtitle("Figure 2: New Zealand Census, Maori speakers by 4 Age Groups")
plot02c + theme (plot.title = element_text(size=20))
#
rm(plot02a,plot2b)
#
#
# Section 3
#
# New Zealand Census Data, No. of Maori language speakers by Regions, 2001 to 2013 ##
#
d003 <- read.csv("~/MaoriStats01/MSpkReg01.csv") # get file from local directory
#
d003a <- d003[c(2,9,6,3)]
#
d003b <- melt(d003a, id.vars="Region")
names(d003b) <- c("Region", "Year", "Population")
#
# plot 3 1st basic, then improve
#
# plot03a <- ggplot(d003b, aes(x=Region, y=Population, fill=Year)) + geom_bar(position="dodge", stat="identity")
# plot03a + ggtitle("Census: Maori language speakers by Region") + theme_bw(base_size = 20)
#
# plot 3 change plot colours
#
# plot03ba <- ggplot(d003b, aes(x=Region, y=Population, fill=Year))
# plot03bb <- plot03ba + geom_bar(position="dodge", stat="identity") + coord_flip()
# plot03bc <- plot03bb + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 19)
# plot03bc + ggtitle("Census: Maori language speakers by Region")
#
# plot 3 final plot, get order of regions right
#
plot03c <- ggplot(d003b, aes(x=Region, y=Population, fill=Year)) + geom_bar(position="dodge", stat="identity")
plot03d <- plot03c + coord_flip() + theme_bw(base_size = 20) + theme (plot.title = element_text(size=20))
plot03e <- plot03d + scale_fill_brewer(palette="Set2", labels =c("2013","2006","2001"))
plot03f <- plot03e + ggtitle("Figure 3: NZ Census: Maori speakers by Region")
plot03g <- plot03f + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury",
                                               "West Coast", "Marlborough", "Nelson",
                                               "Tasman", "Wellington", "Manawatu-Wanganui",
                                               "Taranaki", "Hawke's Bay", "Gisborne",
                                               "Bay of Plenty", "Waikato", "Auckland",
                                               "Northland"))
plot03g + guides(fill = guide_legend(reverse=TRUE)) + theme(axis.title.y = element_blank())
#
rm(plot03c, plot03d, plot03e, plot03f)
#
#
# Section 4 #
#
# New Zealand Census Data, % of Maori language speakers by Regions, 2001 to 2013 #
#
d004a <- d003[c(2,11,8,5)]
#
d004b <- melt(d004a, id.vars="Region")
names(d004b) <- c("Region", "Year", "Percent")
#
# plot 4,  1st basic then improve
#
# plot4a <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity")
# plot4a + theme_bw(base_size = 16) + ggtitle("Census: % of Maori language speakers by Region") + coord_flip()
#
# plot 4 change plot colours
#
# plot04b <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity")
# plot04bb <-cplot04b + scale_fill_brewer(palette="Set2") + theme_bw(base_size = 16) + coord_flip()
# plot04bb + ggtitle("Census: % Maori language speakers by Region")
#
# plot 4  add region labels
#
# plot04c <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity")
# plot04d <- plot04c + scale_fill_brewer(palette="Set2")  + theme_bw(base_size = 16)
# plot04e <- plot04d + ggtitle("Fig. 4: Census: % of Maori speakers by Region")
# plot04e + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury",
# "West Coast", "Marlborough", "Nelson", "Tasman", "Wellington",
# "Manawatu-Wanganui", "Taranaki", "Hawke's Bay", "Gisborne",
# "Bay of Plenty", "Waikato", "Auckland", "Northland")) + theme(axis.title.y = element_blank())
#
# plot 4  Final, get legend labels correct and in order
#
plot04h <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +geom_bar(position="dodge", stat="identity")
plot04i <- plot04h + scale_fill_brewer(palette="Set2",labels =c("2013","2006","2001")) + coord_flip()
plot04j <- plot04i + theme_bw(base_size = 20) + ggtitle("Figure 4: NZ Census, Percentage of Maori speakers by Region")
plot04k <- plot04j + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury", "West Coast",
                                               "Marlborough", "Nelson", "Tasman", "Wellington",
                                               "Manawatu-Wanganui", "Taranaki", "Hawke's Bay",
                                               "Gisborne", "Bay of Plenty", "Waikato", "Auckland",
                                               "Northland")) + theme(axis.title.y = element_blank())
plot04k + guides(fill = guide_legend(reverse=TRUE)) + theme (plot.title = element_text(size=20))
#
rm(plot04h, plot04i, plot04j)
#
# Section 5 #
#
# New Zealand Census Data, % of Maori language speakers by Regions vs. % of total regional pop. 2013 only ##
#
# Create vectors of NZ Census Data for 2013
#
Region <- c("Northland","Auckland","Waikato","Bay of Plenty","Gisborne","Hawke's Bay",
            "Taranaki","Manawatu-Wanganui","Wellington","Tasman","Nelson","Marlborough",
            "West Coast","Canterbury","Otago","Southland")
PerSpkr13 <- c(25.8,17.6,22.9,28.0,30.0,23.8,17.8,20.9,20.3,12.4,17.8,14.5,10.9,14.2,13.2,14.2)
PerPop13 <- c(29.6,10.1,20.7,25.7,45.1,22.9,16.6,19.6,12.4,7.3,9.0,11.0,9.9,7.8,7.1,12.4)
#
# Combine to dataframe
#
d005 <- data.frame(Region,PerSpkr13,PerPop13)
#
rm(Region,PerSpkr13,PerPop13)
#
# plot 5, basic then improve
#
# plot05 <- ggplot(d005, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point() + theme_bw(base_size = 16)
# plot05 + ggtitle("2013 Census: % Speakers by % of Region Pop.")
#
#  plot 5 - add labels, hide key
#
# plot5a <- ggplot(d005, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point() + theme_bw(base_size = 16)
# plot5b <- plot5a + geom_text(aes(label=Region), hjust=1.1, vjust=.5, size=6) + xlim(5,40)+ ylim(5,50)
# plot5b + guides(fill=FALSE) + ggtitle("2013 Census: Maori % Speakers by % of Region Pop.")
#
#  Plot 5, final R plot
#
plot05c <- ggplot(d005, aes(x=PerSpkr13, y=PerPop13, fill=Region)) +geom_point(colour="blue", size=4)
plot05d <- plot05c + theme_bw(base_size = 20) + guides(fill=FALSE)
plot05e <- plot05d + ggtitle("Figure 5: 2013 Census: Percentage of Maori Speakers by Percentage Region Population")
plot05f <- plot05e + theme (plot.title = element_text(size=20))
plot05g <- plot05f + geom_text(aes(label=Region), hjust=1.1, vjust=.5, size=6) + xlim(5,30) + ylim(7,46)
plot05g + xlab("Percentage of Maori Speakers") + ylab("Percentage of Maori")
#
rm(plot05c, plot05d, plot05e, plot05f)
#
# Next clean up plot 5 with Pixelmator (separate overlapping region labels) and then upload
#
# Section 6
#
# Create vectors of NZ Iwi-Region speakers of Maori for 2001, 2006, 2013
#
IwiRegion <- c("01 Te Tai Tokerau/Tamaki Makau Rau (Northland/Auckland)","02 Hauraki (Coromandel)",
               "03 Waikato/Te Rohe Potae (Waikato/King Country)","04 Te Arawa/Taupo (Rotorua/Taupo)",
               "05 Tauranga Moana/Mataatua (Bay of Plenty)","06 Te Tairawhiti (East Coast)",
               "07 Te Matau a Maui/Wairarapa (Hawke's Bay/Wairarapa)","08 Taranaki (Taranaki)",
               "09 Whanganui/Rangitikei (Wanganui/Rangitikei)",
               "10 Manawatu/Horowhenua/Te Whanganui a Tara (Wellington)",
               "11 Te Waipounamu/Wharekauri (South Island/Chatham Islands)")
C2001M <- c(36012,2508,21954,15708,26454,21429,15696,7149,3990,4569,6468)
C2001E <- c(98220,6663,46077,35322,43473,45948,37812,19497,7356,12525,38856)
C2001T <- c(134232,9171,68031,51030,69927,67377,53508,26646,11346,17094,45324)
C2001Per <- c(36.6,37.6,47.6,44.4,60.8,46.6,41.5,36.6,54.2,36.4,16.6)
C2006M <- c(39285,3363,22848,16599,28935,23226,17229,7869,4449,5295,7710)
C2006E <- c(118527,9504,52665,39063,52947,55809,45966,24234,9450,15693,49881)
C2006T <- c(157812,12867,75513,55662,81882,79035,63195,32103,13899,20988,57591)
C2006Per <- c(33.1,35.3,43.3,42.4,54.6,41.6,  37.4,32.4,47,33.7,15.4)
C2013M <- c(37140,3492,24666,16743,28890,21588,16680,7842,4569,6141,7944)
C2013E <- c(124503,10539,60237,43062,57459,56412,48132,27963,11001,19287,55284)
C2013T <- c(161643,14031,84903,59805,86349,78000,64812,35805,15570,25428,63228)
C2013Per <- c(29.8,33.1,40.9,38.8,50.2,38.2,34.6,28,41.5,31.8,14.3)
#
# Combine to dataframe
#
d006 <- data.frame(IwiRegion,C2001M,C2001E,C2001T,C2001Per,C2006M,C2006E,C2006T,C2006Per,C2013M,C2013E,C2013T,C2013Per)
rm(IwiRegion,C2001M,C2001E,C2001T,C2001Per,C2006M,C2006E,C2006T,C2006Per,C2013M,C2013E,C2013T,C2013Per)
#
d006a <- d006[c(1,13,9,5)]
#
d006b <- melt(d006a, id.vars="IwiRegion")
names(d006b) <- c("IwiRegion", "Year", "Percent")
#
d006c <- d006[c(1,10,11)]
d006d <- melt(d006c, id.vars="IwiRegion")
names(d006d) <- c("IwiRegion", "Language", "Number")
#
# Plot 6
#
#
# plot06a <- ggplot(d006d, aes(x=IwiRegion, y=Number, fill=Language)) + geom_bar(stat="identity")
# plot06a+ theme_bw(base_size = 18) + ggtitle("Maori/English Speakers by Iwi Region") + coord_flip()
#
#
plot06b <- ggplot(d006d, aes(x=IwiRegion, y=Number, fill=Language)) + geom_bar(stat="identity")
plot06c <- plot06b + ggtitle("Figure 6A: Maori/English Speakers by Iwi Region 2013 Census")
plot06d <- plot06c + theme_bw(base_size = 20)  + coord_flip()
plot06e <- plot06d + theme (plot.title = element_text(size=18))
plot06f <- plot06e + scale_fill_brewer(palette="Set2",labels =c("Maori","English"))
plot06f + scale_x_discrete(limits=c("11 Te Waipounamu/Wharekauri (South Island/Chatham Islands)",
"10 Manawatu/Horowhenua/Te Whanganui a Tara (Wellington)",
"09 Whanganui/Rangitikei (Wanganui/Rangitikei)", "08 Taranaki (Taranaki)",
"07 Te Matau a Maui/Wairarapa (Hawke's Bay/Wairarapa)","06 Te Tairawhiti (East Coast)",
"05 Tauranga Moana/Mataatua (Bay of Plenty)",
"04 Te Arawa/Taupo (Rotorua/Taupo)",
"03 Waikato/Te Rohe Potae (Waikato/King Country)",
"02 Hauraki (Coromandel)",
"01 Te Tai Tokerau/Tamaki Makau Rau (Northland/Auckland)")) + theme(axis.title.y = element_blank())
#
rm(plot06b, plot06c, plot06d, plot06e)
#
# plot 6 reordered
#
plot06p <- ggplot(d006d, aes(x=IwiRegion, y=Number, fill=Language)) + geom_bar(stat="identity")
plot06q <- plot06p + ggtitle("Figure 6B: Maori/English Speakers by Iwi Region 2013 Census")
plot06r <- plot06q + theme_bw(base_size = 20)  + coord_flip() + theme(axis.title.y = element_blank())
plot06s <- plot06r + theme (plot.title = element_text(size=18))
plot06t <- plot06s + scale_fill_brewer(palette="Set2",labels =c("Maori","English"))
plot06t + scale_x_discrete(limits=c("02 Hauraki (Coromandel)",
"09 Whanganui/Rangitikei (Wanganui/Rangitikei)",
"10 Manawatu/Horowhenua/Te Whanganui a Tara (Wellington)",
"08 Taranaki (Taranaki)",
"11 Te Waipounamu/Wharekauri (South Island/Chatham Islands)",
"07 Te Matau a Maui/Wairarapa (Hawke's Bay/Wairarapa)",
"04 Te Arawa/Taupo (Rotorua/Taupo)",
"06 Te Tairawhiti (East Coast)",
"03 Waikato/Te Rohe Potae (Waikato/King Country)",
"05 Tauranga Moana/Mataatua (Bay of Plenty)",
"01 Te Tai Tokerau/Tamaki Makau Rau (Northland/Auckland)"))
#
rm(plot06p, plot06q, plot06r, plot06s)
#
# plot 7
#
# plot07 <- ggplot(d006b, aes(x=IwiRegion, y=Percent, fill=Year)) + geom_bar(position="dodge", stat="identity")
# plot07 + theme_bw(base_size = 16) + ggtitle("Census: Percentage of Maori language speakers by Iwi Region") + coord_flip()
#
plot07a <- ggplot(d006b, aes(x=IwiRegion, y=Percent, fill=Year)) + geom_bar(position="dodge", stat="identity")
plot07b <- plot07a + coord_flip()  + theme_bw(base_size = 20)
plot07c <- plot07b + scale_fill_brewer(palette="Set2",labels =c("2013","2006","2001"))
plot07d <- plot07c + ggtitle("Figure 7: Census, Percentage of Maori speakers by Iwi Region")
plot07e <- plot07d + theme (plot.title = element_text(size=20))
plot07f <- plot07e + scale_x_discrete(limits=c("11 Te Waipounamu/Wharekauri (South Island/Chatham Islands)",
"10 Manawatu/Horowhenua/Te Whanganui a Tara (Wellington)", "09 Whanganui/Rangitikei (Wanganui/Rangitikei)",
"08 Taranaki (Taranaki)", "07 Te Matau a Maui/Wairarapa (Hawke's Bay/Wairarapa)",
"06 Te Tairawhiti (East Coast)", "05 Tauranga Moana/Mataatua (Bay of Plenty)",
"04 Te Arawa/Taupo (Rotorua/Taupo)", "03 Waikato/Te Rohe Potae (Waikato/King Country)",
"02 Hauraki (Coromandel)","01 Te Tai Tokerau/Tamaki Makau Rau (Northland/Auckland)"))
plot07f + guides(fill = guide_legend(reverse=TRUE)) + theme(axis.title.y = element_blank())
#
rm(plot07a, plot07b, plot07c, plot07d, plot07e)
#
#
## end of R script ##

