library(ggplot2)
library(dplyr)
library(WDI)
library(readr)
library(scales)

gdp_pc <- WDI(indicator="NY.GDP.PCAP.PP.CD", country="all", start=2014, end=2014, extra=TRUE) %>%
  filter(income != "Aggregates") %>%
  select(2,5,3) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD)

ggplot(gdp_pc, aes(x=gdp_percap, y=..count..)) + 
  geom_histogram(binwidth=2500) + 
  ylab("Number of countries") + 
  xlab("GDP per capita (2014)") + 
  # scale_x_continuous(labels = dollar) +
  scale_x_continuous(labels = dollar, limits = c(-2500,160000))

write_csv(gdp_pc, "gdp_pc.csv", na="")





