MaoriStats01
============

This R script looks at Māori language statistics that derive from New Zealand 
Census data currently available on the Web. The time series are irregular. 
I am looking for trends initially, not absolute numbers, as there are errors 
in the reporting (more on this later). I put some files here in Feb 2014
and did some further work in Dec 2014, Jan 2015, May, Dec 2015 and Jan 2016.

All the data comes from Stats NZ (Statistics New Zealand) (see their website).

First, I plot the number of Māori by descent, ethnicity and Māori language 
speakers (only those claiming Māori ethnicity), from 1996 and do a rough 
projection to 2021, the most likely date of the next census. Note a question 
on language use has only been asked since 2001. Figure 1 shows there has been 
a reasonably consistent increase in the number of Māori claiming Māori descent 
and Māori ethnicity, but a reasonably steady decrease in the number of Māori 
language speakers. Normally, I don't like to put legends inside plots but
have done so for consistency and smart phone considerations.

Figure 2 displays Māori language speakers (only those of Māori ethnicity) 
by 4 age groups. Figure 2 clearly shows that in terms of absolute numbers 
there have been reasonably consistent decreases in all age groups (from 2001 
to 2013), except those of over the age of 64.

Figure 3 displays the number of Māori language speakers by Region, from 2001 
to 2013. Again (Figure 3) there is a consistent decrease across all regions. 
The Bay of Plenty, Gisborne, Waikato and Northland have always had 
large Māori populations. Auckland now has a large number of Māori residents 
as a result of internal migration (myself included).

Figure 4 displays the percentage of Māori language speakers by region. 
I.e., what percentage of the Māori population (in that region) claim to be 
speakers of Māori. Obviously, there are larger percentages of Māori 
speakers where there are higher percentages of Māori, although the reasons 
for this are historic and largely reflect delayed language shift in rural 
areas where Māori communities are still intact.

Figure 5 displays the percentage of speakers by the percentage of the 
population for each region as a scatter plot. In some ways this in 
kind of collapsing or combining plots 4 and 5. There is a positive correlation 
between these variables. In early 2016, the ggrepel package was used
to clean up overlapping labels.

Figure 6A shows the number of Maori and English speakers by iwi (tribal) region.
Iwi regions differ somewhat from standard regional boundaries used by
New Zeland government departments/agencies. They make more sense to Maori
or those familiar with iwi distribution in NZ. Remember all Maori speakers
also speak New Zealand English (NZE).

Figure 6B is just a reordering of figure 6A by order of iwi region population.

Figure 7 shows the decrease in percentage of speakers by iwi region between
2001 and 2013. This has been a consistent decrease.

Figure 8 shows percentage of speakers by major (10,000 +) iwi. This figure
is somewhat arbitary and has no real meaning. Note the difference between
Tuhoe (of easter/central North Island) and the South island Ngai Tahu.

Figure 9 presents the percentage of Māori speakers by major iwi, from 2001 to 2013.
Generally there has been a consistent decrease.

The last Census is due was held in March 2018. Data should be available in 2019.





