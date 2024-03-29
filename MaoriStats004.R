# start R script
# Maori Language stats from NZ Censuses, Peter J Keegan last updated 23 Jan 2016
# all data created in the script, self contained but not best way to do things.
# Done using R via RStudio in OSX, if using Windows etc. check Unicode OK.
# object names mostly lower case, or sometimes lowerCamelCase
# d.. usually indicates dataframe, plot.. indicates plot object
#
# March 2022 check ggplot2 code, using depre features !
#
library(ggplot2);library(ggrepel)
library(reshape2)
library(scales)
library(readxl)
#
# Section 1 Overview
# Create vectors of NZ Census (Maori) Data, with addition of my 2018 guestimates
#
year <- c(1991, 1996, 2001, 2006, 2013, 2018)
ethnicity <- c(434847, 523371, 526281, 565329, 598605, 610000)
descent <- c(511278, 579714, 604110, 643977, 668724, 683000)
speakers <- c(NA, 129048, 130482, 131613, 125352, 116000) # no lang. qu pre 1996
#
# Combine to R dataframe
#
d001 <- data.frame(year, descent, ethnicity, speakers)
#
rm(descent, ethnicity, speakers, year) # Get rid of redundant vectors
#
# Convert data from wide to long format and stack
#
d001a <- melt(d001, id.vars = "year",
               measure.vars = c("descent", "ethnicity", "speakers"),
              variable.name = "maori",
                 value.name = "population")
#
# plot 1 1st attempt
#
# ggplot(d001a, aes(x = year, y = population, colour = maori, group = maori)) +
# geom_line() + geom_point(size = 4)
#
# plot 1 Final
#
plot01a <- ggplot(d001a, aes(x = year, y = population, colour = maori,
  group = maori)) + labs(colour = "M\u0101ori")
plot01b <- plot01a + ggtitle(paste0("Figure 1: New Zealand Census 1991-2013",
"\n M\u0101ori Descent, Ethnicity, & Speakers"))
plot01c <- plot01b + geom_line() + geom_point(size = 4)
plot01d <- plot01c + scale_y_continuous(labels = comma,
  breaks = c(0, 100000, 200000, 300000, 400000, 500000, 600000, 680000),
  expand = c(0, 0))
plot01e <- plot01d + expand_limits(y = 0, x = 2018) + theme_bw(base_size = 20)
plot01f <- plot01e + scale_x_continuous(name = "Census Year",
  breaks = c(1991, 1996, 2001, 2006, 2013, 2018), expand = c(.02, 0))
plot01g <- plot01f + theme (plot.title = element_text(size = 20))
plot01g + theme(legend.justification=c(1,.1), legend.position=c(1,.4))
#
#
rm(plot01a, plot01b, plot01c, plot01d, plot01e, plot01f)
#
#
# Section 2 Maori Speakers by 4 age groups
#
# Create vectors of NZ Census Data, Maori speakers by age group by year
# (2001, 2006, 2013)
#
year <- c(2001, 2006, 2013)
agelessthan15 <- c(38673, 35151, 32961)
age15to29 <- c(31479, 31860, 29232)
age30to64 <- c(50967, 53574, 50910)
ageover64 <- c(9363, 11031, 12249)
#
# Combine to dataframe
#
d002 <- data.frame(year, agelessthan15, age15to29, age30to64, ageover64)
#
rm(year, agelessthan15, age15to29, age30to64, ageover64) # delete redund vectors
#
# Convert data from wide to long format & stack
#
d002a <- melt(d002, id.vars = "year",
  measure.vars = c("agelessthan15", "age15to29", "age30to64", "ageover64"),
  variable.name = "agegroup",
  value.name = "pop")
#
#
#
# plot 2, 1st attempt
#
# plot02a <- ggplot(d002a, aes(x = year, y = pop, fill = agegroup)) +
# geom_bar(position = "dodge", stat = "identity")
# plot02a + theme_bw(base_size = 20) +
# ggtitle("Census: Maori language speakers by 4 Age Groups")
#
# change plot 2 colours
#
plot02a <- ggplot(d002a, aes(x = year, y = pop, fill = agegroup)) +
  geom_bar(position = "dodge", stat = "identity")
plot02b <- plot02a + scale_fill_brewer(palette = "Set2", name = "Age Group",
  labels = c("Less Than 15", "15 to 29", "30 to 64", "Over 64")) +
  theme_bw(base_size = 20)
plot02c <- plot02b + ggtitle(paste0("Figure 2: New Zealand Census 2001, 2006, ",
"2013 \n M\u0101ori Speakers by 4 Age Groups"))
plot02d <- plot02c + scale_y_continuous(name = "Population", labels = comma,
  breaks = c(0, 10000, 20000, 30000, 40000, 50000, 60000), expand = c(0, 0))
plot02e <- plot02d + scale_x_continuous(name = "Census Year",
  breaks = c(2001, 2006, 2013), expand = c(0, 0))
plot02f <- plot02e + theme (plot.title = element_text(size = 20))
plot02f + theme(legend.justification=c(1,0), legend.position=c(.8,.7))
#
rm(plot02a, plot02b, plot02c, plot02d, plot02e)
#
#
# Section 3
#
# New Zealand Census, No. of Maori language speakers by Regions, 2001 to 2013
#
# Create vectors of Stats Census Regions
#
rorder <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16)
#
cregion <- c("Northland", "Auckland", "Waikato", "Bay of Plenty", "Gisborne",
  "Hawke's Bay", "Taranaki", "Manawatu-Wanganui", "Wellington",
  "Tasman", "Nelson", "Marlborough", "West Coast", "Canterbury",
  "Otago", "Southland")
cregionrev <- rev(cregion)
#
#
#
spr2001 <- c(12045, 26373, 19749, 19995, 6591, 8550, 3423, 9795, 12423, 459,
  639, 654, 366, 5712, 1800, 1872)
pop2001 <- c(40734, 127626, 72822, 63654, 19365, 32085, 14559, 39267, 51123,
  2778, 3219, 3894, 2547, 31635, 10545, 10038)
per2001 <- c(29.6, 20.7, 27.1, 31.4, 34, 26.6, 23.5, 24.9, 24.3, 16.5,
  19.9, 16.8, 14.4, 18.1, 17.1, 18.6)
spr2006 <- c(12141, 27162, 19422, 20508, 6276, 8493, 3216, 10047, 12552,
  450, 666, 669, 363, 5979, 1896, 1710)
pop2006 <- c(43530, 137133, 76572, 67662, 19761, 33555, 15798, 42285,
  55437, 3063, 3615, 4275, 2916, 36669, 12273, 10422)
per2006 <- c(27.89, 19.81, 25.36, 30.31, 31.76, 25.31, 20.36, 23.76,
  22.64, 14.69, 18.42, 15.65, 12.45, 16.31, 15.45, 16.41)
spr2013 <- c(11586, 25173, 19176, 19326, 5901, 8256, 3228, 9114, 11841,
  426, 741, 693, 345, 5958, 1902, 1647)
pop2013 <- c(44931, 142770, 83742, 68943, 19683, 34662, 18150, 43599,
  58338, 3441, 4167, 4776, 3171, 41910, 14385, 11607)
per2013 <- c(25.79, 17.63, 22.9, 28.03, 29.98, 23.82, 17.79, 20.9,
  20.3, 12.38, 17.78, 14.51, 10.88, 14.22, 13.22, 14.19)
#
d003 <- data.frame(rorder, cregion, spr2001, pop2001, per2001,
  spr2006, pop2006, per2006, spr2013, pop2013, per2013)
#
rm(rorder, spr2001, pop2001, per2001, spr2006, pop2006,
  per2006, spr2013, pop2013, per2013)
#
d003a <- d003[c(2, 9, 6, 3)]
#
d003b <- melt(d003a, id.vars = "cregion",
    measure.vars = c("spr2001", "spr2006", "spr2013"),
    variable.name = "Year",
    value.name = "Population")
#
# plot 3 1st basic, then improve
#
# ggplot(d003b, aes(x = cregion, y = Population, fill = Year)) +
# geom_bar(position = "dodge", stat = "identity")
#
#
# plot 3 final plot
#
plot03c <- ggplot(d003b, aes(x = cregion, y = Population, fill = Year)) +
  geom_bar(position = "dodge", stat = "identity")
plot03d <- plot03c + coord_flip() + theme_bw(base_size = 20) +
  theme (plot.title = element_text(size=20))
plot03e <- plot03d + scale_fill_brewer(palette = "Set2",
  labels =c("2013", "2006", "2001"))
plot03f <- plot03e + ggtitle(paste0("Figure 3: New Zealand Census 2001, 2006, ",
"2013\nM\u0101ori Speakers by Region"))
plot03g <- plot03f + scale_x_discrete(limits = cregionrev)
plot03f <- plot03g + scale_y_continuous(labels = comma,
  breaks = c(0, 5000, 10000, 15000, 20000, 25000, 30000), expand = c(0, 0))
plot03g <- plot03f + guides(fill = guide_legend(reverse=TRUE)) +
  theme(axis.title.y = element_blank())
plot03g + theme(legend.justification=c(1,0), legend.position=c(1,.4))
#
rm(plot03c, plot03d, plot03e, plot03f)
#
#
# Section 4 #
#
# New Zealand Census % of Maori language speakers by Regions, 2001 to 2013
#
d004a <- d003[c(2, 11, 8, 5)]
#
d004b <- melt(d004a, id.vars = "cregion",
                measure.vars = c("per2013", "per2006", "per2001"),
                variable.name = "Year",
                   value.name = "Percent")
#
#
#names(d004b) <- c("Region", "Year", "Percent")
#
# plot 4, 1st basic then improve
#
# plot4a <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +
# geom_bar(position="dodge", stat="identity")
# plot4a + theme_bw(base_size = 16) +
# ggtitle("Census: % of Maori language speakers by Region") + coord_flip()
#
# plot 4 change plot colours
#
# plot04b <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +
# geom_bar(position="dodge", stat="identity")
# plot04bb <- cplot04b + scale_fill_brewer(palette="Set2") +
# theme_bw(base_size = 16) + coord_flip()
# plot04bb + ggtitle("Census: % Maori language speakers by Region")
#
# plot 4 add region labels
#
# plot04c <- ggplot(d004b, aes(x=Region, y=Percent, fill=Year)) +
# geom_bar(position="dodge", stat="identity")
# plot04d <- plot04c + scale_fill_brewer(palette="Set2") +
# theme_bw(base_size = 16)
# plot04e <- plot04d + ggtitle("Fig. 4: Census: % of Maori speakers by Region")
# plot04e + scale_x_discrete(limits=c("Southland", "Otago", "Canterbury",
# "West Coast", "Marlborough", "Nelson", "Tasman", "Wellington",
# "Manawatu-Wanganui", "Taranaki", "Hawke's Bay", "Gisborne",
# "Bay of Plenty", "Waikato", "Auckland", "Northland")) +
# theme(axis.title.y = element_blank())
#
# plot 4 Final, get legend labels correct and in order
#
plot04h <- ggplot(d004b, aes(x = cregion, y = Percent, fill = Year)) +
  geom_bar(position = "dodge", stat = "identity")
plot04i <- plot04h + scale_fill_brewer(palette = "Set2",
  labels =c("2013", "2006", "2001")) + coord_flip()
plot04j <- plot04i + theme_bw(base_size = 20)
plot04k <- plot04j + ggtitle(paste0("Figure 4: New Zealand Census 2001, 2006, ",
"2013\n Percentage of M\u0101ori Speakers by Region"))
plot04l <- plot04k + scale_x_discrete(limits = cregionrev)
plot04m <- plot04l + theme(axis.title.y = element_blank())
plot04n <- plot04m + scale_y_continuous(breaks = c(0, 5, 10, 15, 20, 25, 30,
  35), expand = c(0, 0))
plot04o <- plot04n + guides(fill = guide_legend(reverse = TRUE))
plot04p <- plot04o + theme (plot.title = element_text(size = 20))
plot04p + theme(legend.justification=c(1,0), legend.position=c(1,.4))
#
rm(plot04h, plot04i, plot04j, plot04k, plot04l, plot04m, plot04n, plot04o)
#
# Section 5
#
# NZ Census Data % of Maori speakers by Regions vs. % of total Regional pop.2013
#
# Create vectors of NZ Census Data for 2013
#
# Region (already created)
#
perSpkr13 <- c(25.8, 17.6, 22.9, 28.0, 30.0, 23.8, 17.8, 20.9, 20.3,
  12.4, 17.8, 14.5, 10.9, 14.2, 13.2, 14.2)
#
perPop13 <- c(29.6, 10.1, 20.7, 25.7, 45.1, 22.9, 16.6, 19.6, 12.4,
  7.3, 9.0, 11.0, 9.9, 7.8, 7.1, 12.4)
#
# Combine to dataframe
#
d005 <- data.frame(cregion, perSpkr13, perPop13)
#
rm(perSpkr13, perPop13)
#
#
#
# plot 5, basic then improve
#
# plot05 <- ggplot(d005, aes(x=perSpkr13, y=perPop13, fill=cregion)) +
# geom_point() + theme_bw(base_size = 16)
# plot05 + ggtitle("2013 Census: % Speakers by % of Region Pop.")
#
# plot 5 - add labels, hide key
#
# plot5a <- ggplot(d005, aes(x=perSpkr13, y=perPop13, fill=cregion)) +
# geom_point() + theme_bw(base_size = 16)
# plot5b <- plot5a + geom_text(aes(label=Region), hjust=1.1, vjust=.5, size=6) +
# xlim(5,40)+ ylim(5,50)
# plot5b + guides(fill=FALSE) +
# ggtitle("2013 Census: Maori % Speakers by % of Region Pop.")
#
# Plot 5, ex final R plot 2015
#
# plot05c <- ggplot(d005, aes(x = perSpkr13, y = perPop13, fill = cregion)) +
#   geom_point(colour = "blue", size = 4)
# plot05d <- plot05c + theme_bw(base_size = 20) + guides(fill=FALSE)
# plot05e <- plot05d + ggtitle(paste0("Figure 5: 2013 Census: % of M\u0101ori ",
# "Speakers by Percentage Region Population"))
# plot05f <- plot05e + theme (plot.title = element_text(size = 18))
# plot05g <- plot05f + geom_text(aes(label = cregion), hjust = 1.1,
#   vjust = .5, size = 6) + xlim(5, 30) + ylim(7, 46)
# plot05g + xlab("Percentage of M\u0101ori Speakers in Region") +
#   ylab("Percentage of M\u0101ori in Region")
#
# rm(plot05c, plot05d, plot05e, plot05f)
#
# Plot 5, Final R plot 2016
# use Geoms from ggrepel to fix overlapping labels
#
plot05cc <- ggplot(d005, aes(x = perSpkr13, y = perPop13, fill = cregion)) +
  geom_point(colour = "blue", size = 3)
plot05cd <- plot05cc + theme_bw(base_size = 20) + guides(fill=FALSE)
plot05ce <- plot05cd + ggtitle(paste0("Figure 5: 2013 Census: Percentage ",
    "of M\u0101ori Speakers by Percentage Region Population"))
plot05cf <- plot05ce + theme (plot.title = element_text(size = 18))
plot05cg <- plot05cf + geom_text_repel(aes(perSpkr13, perPop13, label = cregion),
    size = 6.5, force = 1) + xlim(5, 30) + ylim(7, 46)
plot05cg + xlab("Percentage of M\u0101ori Speakers in Region") +
  ylab("Percentage of M\u0101ori in Region")
#
rm(plot05cc, plot05cd, plot05ce, plot05cf)
#
#
#
# Section 6
#
# Create vectors of NZ Iwi-Region speakers of Maori for 2001, 2006, 2013
#
iwiregion <- c("01 Te Tai Tokerau/Tāmaki Makaurau\n (Northland/Auckland)",
  "02 Hauraki\n (Coromandel)",
  "03 Waikato/Te Rohe Pōtae\n (Waikato/King Country)",
  "04 Te Arawa/Taupō\n (Rotorua/Taupo)",
  "05 Tauranga Moana/Mātaatua\n (Bay of Plenty)",
  "06 Te Tairāwhiti\n (East Coast)",
  "07 Te Matau a Māui/Wairarapa\n (Hawke's Bay/Wairarapa)",
  "08 Taranaki\n (Taranaki)",
  "09 Whanganui/Rangitīkei\n (Wanganui/Rangitikei)",
  "10 Manawatū/Horowhenua/\n Te Whanganui a Tara (Wellington)",
  "11 Te Waipounamu/Wharekauri\n (South Island/Chatham Islands)")
#
iwiregionrev <- rev(iwiregion) # useful for plots
#
#
#
c2001M <- c(36012, 2508, 21954, 15708, 26454, 21429, 15696, 7149, 3990, 4569,
  6468)
c2001E <- c(98220, 6663, 46077, 35322, 43473, 45948, 37812, 19497, 7356,
  12525, 38856)
c2001T <- c(134232, 9171, 68031, 51030, 69927, 67377, 53508, 26646,
  11346, 17094, 45324)
c2001Per <- c(36.6, 37.6, 47.6, 44.4, 60.8, 46.6, 41.5, 36.6, 54.2, 36.4, 16.6)
c2006M <- c(39285, 3363, 22848, 16599, 28935, 23226, 17229, 7869, 4449,
  5295, 7710)
c2006E <- c(118527, 9504, 52665, 39063, 52947, 55809, 45966, 24234,
  9450, 15693, 49881)
c2006T <- c(157812, 12867, 75513, 55662, 81882, 79035, 63195, 32103,
  13899, 20988, 57591)
c2006Per <- c(33.1, 35.3, 43.3, 42.4, 54.6, 41.6, 37.4, 32.4, 47, 33.7, 15.4)
c2013M <- c(37140, 3492, 24666, 16743, 28890, 21588, 16680, 7842,
  4569, 6141, 7944)
c2013E <- c(124503, 10539, 60237, 43062, 57459, 56412, 48132, 27963,
  11001, 19287, 55284)
c2013T <- c(161643, 14031, 84903, 59805, 86349, 78000, 64812, 35805,
  15570, 25428, 63228)
c2013Per <- c(29.8, 33.1, 40.9, 38.8, 50.2, 38.2, 34.6, 28,
  41.5, 31.8, 14.3)
#
# Combine to dataframe
#
d006 <- data.frame(iwiregion, c2001M, c2001E, c2001T, c2001Per, c2006M,
  c2006E, c2006T, c2006Per, c2013M, c2013E, c2013T, c2013Per)
rm(c2001M, c2001E, c2001T, c2001Per, c2006M, c2006E, c2006T,
  c2006Per, c2013M, c2013E, c2013T, c2013Per)
#
d006a <- d006[c(1, 13, 9, 5)]
#
d006b <- melt(d006a, id.vars = "iwiregion")
names(d006b) <- c("iwiregion", "Year", "Percent")
#
d006c <- d006[c(1, 10, 11)]
d006d <- melt(d006c, id.vars = "iwiregion")
names(d006d) <- c("iwiregion", "Language", "Number")
#
# Plot 6
#
#
# plot06a <- ggplot(d006d, aes(x=iwiregion, y=Number, fill=Language)) +
# geom_bar(stat="identity")
# plot06a+ theme_bw(base_size = 18) +
# ggtitle("Maori/English Speakers by Iwi Region") + coord_flip()
#
#
plot06b <- ggplot(d006d, aes(x = iwiregion, y = Number, fill = Language)) +
  geom_bar(stat = "identity")
plot06c <- plot06b + ggtitle(paste0("Figure 6A: New Zealand Census 2013\n",
"M\u0101ori/English Speakers by Iwi Region"))
plot06d <- plot06c + theme_bw(base_size = 20) + coord_flip()
plot06e <- plot06d + theme (plot.title = element_text(size = 18))
plot06f <- plot06e + scale_fill_brewer(palette = "Set2",
  labels = c("M\u0101ori (& English)", "English Only"))
plot06g <- plot06f + scale_x_discrete(limits = iwiregionrev) +
  theme(axis.title.y = element_blank())
plot06h <- plot06g + scale_y_continuous(breaks = c(0, 25000, 50000, 75000,
  100000, 125000, 150000), expand = c(0, 0))
plot06h + theme(legend.justification=c(1,0), legend.position=c(1,.4))
#
rm(plot06b, plot06c, plot06d, plot06e, plot06f, plot06g)
#
# plot 6 reordered
#
plot06p <- ggplot(d006d, aes(x = iwiregion, y = Number, fill = Language)) +
  geom_bar(stat = "identity")
plot06q <- plot06p + ggtitle(paste0("Figure 6B: New Zealand Census 2013 \n",
"M\u0101ori/English Speakers by Iwi Region"))
plot06r <- plot06q + theme_bw(base_size = 20) + coord_flip() +
  theme(axis.title.y = element_blank())
plot06s <- plot06r + theme (plot.title = element_text(size = 18))
plot06t <- plot06s +
  scale_fill_brewer(palette = "Set2",
  labels =c("M\u0101ori (& English)", "English Only"))
plot06u <- plot06t + scale_x_discrete(limits =c("02 Hauraki\n (Coromandel)",
  "09 Whanganui/Rangitīkei\n (Wanganui/Rangitikei)",
  "10 Manawatū/Horowhenua/\n Te Whanganui a Tara (Wellington)",
  "08 Taranaki\n (Taranaki)",
  "11 Te Waipounamu/Wharekauri\n (South Island/Chatham Islands)",
  "07 Te Matau a Māui/Wairarapa\n (Hawke's Bay/Wairarapa)",
  "04 Te Arawa/Taupō\n (Rotorua/Taupo)",
  "06 Te Tairāwhiti\n (East Coast)",
  "03 Waikato/Te Rohe Pōtae\n (Waikato/King Country)",
  "05 Tauranga Moana/Mātaatua\n (Bay of Plenty)",
  "01 Te Tai Tokerau/Tāmaki Makaurau\n (Northland/Auckland)"))
plot06v <- plot06u + scale_y_continuous(breaks = c(0, 25000, 50000, 75000,
  100000, 125000, 150000), expand = c(0, 0))
plot06v + theme(legend.justification=c(1,0), legend.position=c(1,.4))
#
rm(plot06p, plot06q, plot06r, plot06s, plot06t, plot06u)
#
# Section 7
# plot 7
#
# plot07 <- ggplot(d006b, aes(x=IwiRegion, y=Percent, fill=Year)) +
# geom_bar(position="dodge", stat="identity")
# plot07 + theme_bw(base_size = 16) +
# ggtitle("Census: Percentage of Maori language speakers by Iwi Region") +
# coord_flip()
#
plot07a <- ggplot(d006b, aes(x = iwiregion, y = Percent, fill = Year)) +
  geom_bar(position = "dodge", stat = "identity")
plot07b <- plot07a + coord_flip() + theme_bw(base_size = 20)
plot07c <- plot07b +
  scale_fill_brewer(palette = "Set2", labels = c("2013", "2006", "2001"))
plot07d <- plot07c + ggtitle(paste0("Figure 7: New Zealand Census 2001, 2006, ",
"2013\n Percentage of M\u0101ori Speakers by Iwi Region"))
plot07e <- plot07d + theme (plot.title = element_text(size = 20))
plot07f <- plot07e + scale_x_discrete(limits = iwiregionrev)
plot07g <- plot07f + scale_y_continuous(breaks = c(0, 10, 20, 30,
  40, 50, 60), expand = c(0, 0))
plot07h <- plot07g + guides(fill = guide_legend(reverse = TRUE)) +
  theme(axis.title.y = element_blank())
plot07h + theme(legend.justification=c(1,0), legend.position=c(1, .75))
#
rm(plot07a, plot07b, plot07c, plot07d, plot07e, plot07f, plot07g)
#
# Section 8, iwi 10k+, 2013
#
iwi10k <-c("Ngapuhi", "Ngati Porou", "Ngai Tahu / Kai Tahu", "Waikato",
  "Ngati Tuwharetoa", "Ngati Maniapoto", "Tuhoe",
  "Ngati Kahungunu ki Te Wairoa", "Te Arawa",
  "Ngati Kahungunu, region unspecified", "Te Rarawa", "Ngati Awa",
  "Te Atiawa (Taranaki)", "Ngati Raukawa (ki te Tonga)",
  "Ngati Whatua", "Te Whanau-a-Apanui","Ngaiterangi",
  "Whakatohea", "Tainui", "Te Ati Hau Nui-a-Paparangi",
  "Ngati Kahungunu ki Heretaunga", "Ngati Raukawa (Waikato)")
iwi10krev  <- rev(iwi10k)
m2001 <-c(26646, 19431, 5148, 12636, 8958, 8031, 12363, 4332, 5241, 7278,
  4107, 4746, 2070, 3084, 3447, 4353, 3609, 3474, 3786, 3342, 2460, 1497)
e2001 <-c(76005, 41907, 33639, 23118, 20184, 19041, 16923, 10236, 11325,
  17481, 7347, 8247, 7953, 7860, 8580, 5562, 5853, 6438, 8940, 5433,
  4428, 3609)
t2001 <-c(102651, 61338, 38787, 35754, 29142, 27072, 29286, 14568, 16566,
  24759, 11454, 12993, 10023, 10944, 12027, 9915, 9462, 9912, 12726, 8775,
  6888, 5106)
per2001 <-c(26.0, 31.7, 13.3, 35.3, 30.7, 29.7, 42.2, 29.7, 31.6, 29.4,
  35.9, 36.5, 20.7, 28.2, 28.7, 43.9, 38.1, 35.0, 29.8, 38.1, 35.7, 29.3)
m2006 <-c(29733, 21153, 5973, 11412, 10428, 9375, 13344, 5535, 7458, 4977,
  4959, 5133, 2391, 3444, 4194, 4821, 4209, 4014, 4128, 3684, 3084, 2244)
e2006 <-c(92805, 51084, 43110, 22203, 24300, 24291, 19500, 15432, 15978,
  13920, 9960, 10164, 10383, 9786, 10581, 6993, 7986, 8106, 10221, 6807,
  6447, 5862)
t2006 <-c(122538, 72237, 49083, 33615, 34728, 33666, 32844, 20967, 23436,
  18897, 14919, 15297, 12774, 13230, 14775, 11814, 12195, 12120, 14349,
  10491, 9531, 8106)
per2006 <-c(24.3, 29.3, 12.2, 33.9, 30.0, 27.8, 40.6, 26.4, 31.8, 26.3,
  33.2, 33.6, 18.7, 26.0, 28.4, 40.8, 34.5, 33.1, 28.8, 35.1, 32.4, 27.7)
m2013 <-c(28053, 19425, 6270, 12879, 10011, 9429, 13413, 5460, 5670,
  4422, 5064, 5262, 2679, 3678, 3732, 5058, 4347, 3819, 2544, 3738, 3300,
  2763)
e2013 <-c(97302, 51447, 48132, 27252, 25776, 25902, 21522, 15492, 14046,
  14049, 11349, 10884, 12477, 11343, 10995, 7797, 8496, 8334, 9264, 7947,
  7656, 7254)
t2013 <-c(125355, 70872, 54402, 40131, 35787, 35331, 34935, 20952, 19716,
  18471, 16413, 16146, 15156, 15021, 14727, 12855, 12843, 12153, 11808,
  11685, 10956, 10017)
per2013 <-c(22.4, 27.4, 11.5, 32.1, 28.0, 26.7, 38.4, 26.1, 28.8, 23.9,
  30.9, 32.6, 17.7, 24.5, 25.3, 39.3, 33.8, 31.4, 21.5, 32.0, 30.1, 27.6)
#
d008 <- data.frame(iwi10k, m2001, e2001, t2001, per2001, m2006, e2006, t2006,
per2006, m2013, e2013, t2013, per2013)
#
rm(m2001, e2001, t2001, per2001, m2006, e2006, t2006, per2006, m2013,
  e2013, t2013, per2013)
#
d008a <- d008[c(1, 13, 9, 5)]
#
d008b <- melt(d008a, id.vars = "iwi10k")
names(d008b) <- c("iwi10k", "Year", "Percent")
#
d008c <- d008[c(1, 10, 11)]
d008d <- melt(d008c, id.vars = "iwi10k")
names(d008d) <- c("iwi10k", "Language", "Number")
#
# plot08a <- ggplot(d008d, aes(x=Iwi, y=Number, fill=Language)) +
# geom_bar(stat="identity")
# plot08a+ theme_bw(base_size = 18) +
# ggtitle("Maori/English Speakers by Major Iwi") + coord_flip()
#
#
plot08b <- ggplot(d008d, aes(x = iwi10k, y = Number, fill = Language)) +
  geom_bar(stat = "identity")
plot08c <- plot08b + ggtitle(paste0("Figure 8: New Zealand Census 2013\n",
"M\u0101ori/English Speakers by Major Iwi"))
plot08d <- plot08c + theme_bw(base_size = 20) + coord_flip()
plot08e <- plot08d + theme (plot.title = element_text(size=20))
plot08f <- plot08e+ theme(axis.title.y = element_blank())
plot08g <- plot08f + scale_fill_brewer(palette = "Set2",
  labels = c("M\u0101ori (& English)", "English Only"))
plot08h <- plot08g + scale_x_discrete(limits = iwi10krev)
plot08i <- plot08h + scale_y_continuous(breaks = c(0, 20000, 40000, 60000,
  80000, 100000, 120000), expand = c(0, 0))
plot08i + theme(legend.justification=c(1,0), legend.position=c(1,.4))
#
rm(plot08b, plot08c, plot08d, plot08e, plot08f, plot08g, plot08h)
#
#
plot08m <- ggplot(d008b, aes(x = iwi10k, y = Percent, fill = Year)) +
  geom_bar(position = "dodge", stat = "identity")
plot08n <- plot08m + coord_flip() + theme_bw(base_size = 20)
plot08o <- plot08n + scale_fill_brewer(palette = "Set2",
  labels = c("2013", "2006", "2001"))
plot08p <- plot08o + ggtitle(paste0("Figure 9: New Zealand Census 2001, 2006, ",
"2013\n Percentage of M\u0101ori Speakers by Major Iwi"))
plot08q <- plot08p + theme (plot.title = element_text(size=20))
plot08r <- plot08q + scale_x_discrete(limits = iwi10krev)
plot08s <- plot08r + scale_y_continuous(breaks = c(0, 10, 20, 30,
  40), expand = c(0, 0))
plot08t <- plot08s + guides(fill = guide_legend(reverse = TRUE)) +
  theme(axis.title.y = element_blank())
plot08t + theme(legend.justification=c(1,0), legend.position=c(1,.4))
#
rm(plot08m, plot08n, plot08o, plot08p, plot08q, plot08r, plot08s)
#
#
# Te Kupenga Data
#
# Figure 10
#
d010a <- read_excel("kupe-iwid1a.xls", sheet = 1) # columns set for stacks
str(d010a)
d010b <- d010a
#
d010c <- melt(d010b, id.vars = "iwi")
names(d010c) <- c("iwi", "Proficiency", "Percent")
str(d010c)
#
levels(d010c$Proficiency)
#
# either order factor Proficency for plotting or change column positions
#
# d010d <- d010c
# d010d$Proficiency <- factor(d010d$Proficiency, levels =c("epervewe",
#  "dperwell", "cperfw", "bpernot", "apernom"))
#
d010c$iwi <- factor(d010c$iwi, levels =c("Ngaitahu", "Tuwharetoa",
 "Maniapoto", "Ngapuhi","Ngati Porou", "Te Arawa", "Waikato",
 "Kahungunu (Wairoa)", "Tuhoe", "All"))
levels(d010c$iwi)
#
# theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
#
#
# plot below no longer works, probably ggplot change ! NEED TO FIX
#
ggplot(d010c, aes(x=iwi, y = Percent, fill = Proficiency)) + coord_flip() +
  geom_bar(stat = "identity") + theme_bw(base_size = 18) +
  scale_y_discrete(breaks = c(0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100),
  expand = c(0, 0)) + scale_fill_brewer(palette = "Blues", direction = -1,
  labels =c("very well", "well", "fairly well", "not very well", "few words"),
  name = "Te Reo M\u0101ori\n Proficiency") +
  ggtitle(paste0("Figure 10: Te Kupenga 2013, M\u0101ori Speaker",
  " Oral Proficiency by Major Iwi"))
#
#
#
# end of R script
