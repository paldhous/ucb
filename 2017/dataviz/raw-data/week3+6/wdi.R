# load required packages
library(WDI)
library(dplyr)
library(readr)
library(stringr)

# get data

# create list of indicators to be imported
indic_list <- c("NY.GDP.PCAP.PP.CD", "SP.DYN.LE00.IN", "SP.POP.TOTL", "SP.DYN.CBRT.IN","SH.DYN.NMRT")

# import indicators into single data frame and rename fields
indicators <- WDI(indicator=indic_list, country="all", start=1990, end=2015, extra=T, cache=NULL) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD, life_expect=SP.DYN.LE00.IN, population=SP.POP.TOTL, birth_rate=SP.DYN.CBRT.IN, neonat_mortal_rate=SH.DYN.NMRT) %>%
  filter(income != "Aggregates") %>%
  select(1,9,2:8,10,14)

# for week 6
indicators <- indicators %>%
  select(-life_expect)

co2 <- WDI(indicator="EN.ATM.CO2E.PC", country="all", start=1990, end=2014, extra=T, cache=NULL) %>%
  filter(income != "Aggregates") %>%
  select(1:5)

indicators <- WDI(indicator=indic_list, country="all", start=1990, end=2015, extra=T, cache=NULL) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD, life_expect=SP.DYN.LE00.IN, population=SP.POP.TOTL, birth_rate=SP.DYN.CBRT.IN, neonat_mortal_rate=SH.DYN.NMRT) %>%
  filter(income != "Aggregates") %>%
  select(1,9,2:8,10,14)


indicators$region <- gsub("all income levels","", indicators$region)
indicators$region <- gsub("\\(|\\)","", indicators$region)
indicators$region <- str_trim(indicators$region)
indicators$income <- gsub(": nonOECD","", indicators$income)
indicators$income <- gsub(": OECD","", indicators$income)

# write to csv
write_csv(indicators, "nations.csv", na="")
write_csv(co2,"co2.csv", na="")
