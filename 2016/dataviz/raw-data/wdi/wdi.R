# load required packages
library(dplyr)
library(WDI)
library(ggplot2)
library(scales)

# import World Bank data

# create list of indicators to be imported
indic_list <- c("NY.GDP.PCAP.PP.CD", "SP.DYN.LE00.IN", "SP.POP.TOTL", "SP.DYN.CBRT.IN","SH.DYN.NMRT")

# import indicators into single data frame and rename fields
indicators <- WDI(indicator=indic_list, country="all", start=1990, end=2014) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD, life_expect=SP.DYN.LE00.IN, population=SP.POP.TOTL, birth_rate=SP.DYN.CBRT.IN, neonat_mortal=SH.DYN.NMRT, iso_a2=iso2c)

# import nations join table
nations_join <- read.csv("nations_join.csv", stringsAsFactors=FALSE)

# import regions/income group data
groups <- read.csv("groups.csv", stringsAsFactors=FALSE)

# join to income group data and select desired fields
indicators2 <- inner_join(indicators, nations_join) %>%
  inner_join(groups) %>%
  select(iso_a3, country, year, region, income_group, gdp_percap, life_expect, population, birth_rate, neonat_mortal)

# separate join for Namibia, because R interprets NA country code as null value
namibia <- inner_join(indicators, nations_join, c("country"="iso_country")) %>%  
  inner_join(groups) %>%
  filter(country=="Namibia") %>%
  select(iso_a3, country, year, region, income_group, gdp_percap, life_expect, population, birth_rate, neonat_mortal)

# Add Namibia to the data frame
nations <- rbind(indicators2, namibia) %>%
  arrange(iso_a3) 

#export data for week3
week3 <- select(nations, iso_a3, country, year, region, income_group, gdp_percap, population, birth_rate, neonat_mortal)

write.csv(week3, "nations.csv", row.names = FALSE, na = "")

# prepare and export data for join to GDP map
gdp_pc <- filter(nations, year == 2014) %>%
  select(iso_a3, gdp_percap)

write.csv(gdp_pc, "gdp_pc.csv", row.names = FALSE, na = "-99")

# and export for week 1
gdp_pc2 <- filter(nations, year == 2014) %>%
  select(country,iso_a3, gdp_percap)

write.csv(gdp_pc2, "gdp_pc2.csv", row.names = FALSE, na = "")

# histogram of gdp_pc in 2014
ggplot(gdp_pc, aes(x=gdp_percap, y=..count..)) + geom_histogram(binwidth=2500) + ylab("Number of countries") + xlab("GDP per capita (2014)") + scale_x_continuous(labels = dollar)

# scatterplot of gdp_pc vs life_expect in 2013
scatter <- filter(nations, year == 2013) %>%
  select(iso_a3, life_expect, gdp_percap)

#linear
ggplot(scatter, aes(x=gdp_percap, y=life_expect)) + geom_point(size=4, alpha=0.5) + scale_x_continuous(labels = dollar) + stat_smooth(formula=y~log(x), se=FALSE) + xlab("GDP per capita") + ylab("Life expectancy at birth")
#logarithmic
ggplot(scatter, aes(x=gdp_percap, y=life_expect)) + geom_point(size=4, alpha=0.5) + scale_x_log10(labels = dollar) + geom_smooth(se=FALSE, method="lm") + xlab("GDP per capita") + ylab("Life expectancy at birth")




