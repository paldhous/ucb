# load required packages
library(WDI)
library(dplyr)
library(readr)
library(stringr)

# get data

# create list of indicators to be imported
indic_list <- c("NY.GDP.PCAP.PP.CD", "SP.DYN.LE00.IN", "SP.POP.TOTL", "EN.ATM.CO2E.PC")

# import indicators into single data frame and rename fields
indicators <- WDI(indicator=indic_list, country="all", start=1990, end=2016, extra=T, cache=NULL) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD, life_expect=SP.DYN.LE00.IN, population=SP.POP.TOTL, co2_percap=EN.ATM.CO2E.PC) %>%
  filter(income != "Aggregates") %>%
  select(1,8,2:7,9,13)

indicators$region <- gsub("all income levels","", indicators$region)
indicators$region <- gsub("\\(|\\)","", indicators$region)
indicators$region <- str_trim(indicators$region)
indicators$income <- gsub(": nonOECD","", indicators$income)
indicators$income <- gsub(": OECD","", indicators$income)

nations2015 <- indicators %>%
  filter(year==2015) %>%
  select(-co2)

# write to csv
write.csv(indicators, "nations.csv", na="", row.names = F)
write.csv(nations2015,"nations_2015.csv", na="", row.names = F)

nations1 <- indicators %>%
  select(-co2_percap)

nations2 <- indicators %>%
  select(iso3c,year,co2_percap)

# write to csv
write.csv(nations1, "nations1.csv", na="", row.names = F)
write.csv(nations2,"nations2.csv", na="", row.names = F)

