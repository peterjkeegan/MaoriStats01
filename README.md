MaoriStats01
============

This R script looks at Māori language statistics that derive from New Zealand Census data currently available on the Web. The time series are irregular. I am looking for trends initially, not absolute numbers, as there are errors in the reporting (more on this later). This is my 1st effort, which I'll improve and add to at the later stage.

The CSV file is something I constructed from Stats NZ Excel spreadsheets (see the Stats NZ website).

I divided the R script into a number of sections, mainly so its easy for me to remember what I did.

In the 1st section I plot the number of Māori by descent, ethnicity and Māori language speakers (only those claiming Māori ethnicity), from 1996 and do a rough projection to 2021, the most likely date of the next census. Note a question on language use has only been asked since 2001. Plot 1, shows there has been a reasonably consistent increase in the number of Māori claiming Māori descent and Māori ethnicity, but a reasonably steady decrease in the number of Māori language speakers. In the next sections, I look more closely at the Māori language speakers in the following sections.

Section 2 I plot Māori language speakers (only those of Māori ethnicity) by 4 age groups. Plot 2 clearly shows that in terms of absolute numbers there have been reasonably consistent decreases in all age groups (from 2001 to 2013), except those of over the age of 64.

Section 3 I plot the number of Māori language speakers by Region, from 2001 to 2013. Again (Plot 3) there is a consistent decrease across all regions. The Bay of Plenty, Gisborne, Waikato and Northland have always had large Māori populations. Auckland now has a large number of Māori residents as a result of internal migration (myself included).

Section 4 I plot the percentage of Māori language speakers by region. I.e., what percentage of the Māori population (in that region) claim to be speakers of Māori (plot 4). Obviously, where there are larger percentages of Māori there are higher percentages of Māori speakers, althought the reasons for this are historic and largely reflect delayed language shift in rural areas where Māori communities are still intact.

Section 5 I plot the percentage of speakers by the percentage of the population for each region as a scatter plot (Plot 5), in some ways this in kind of collapsing or combining plots 4 and 5. There is a positive correlation between these variables.

WARNINGs - In some cases regional analyses can be misleading, as there is a lot of variation in regions such as Auckland and the Bay of Plenty. This needs to be explored by looking at next lower level, i.e., District Councils (yes I am planning to do this).  There are both errors and over reporting of results in these data.

Where to from here ? I'll look at iwi (Māori tribes), and defacto social class measures such as income and education.