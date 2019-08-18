# load required packages
library(readr)
library(dplyr)
library(tidyr)
library(countrycode)

# carbon dioxide emissions
# data from http://www.globalcarbonatlas.org/en/CO2-emissions
gcp <- read_delim("gcp_co2.txt", skip=1, delim = ";") %>%
  gather(country,emissions,-X1) %>%
  rename(year = X1) %>%
  filter(!grepl("Sources|Territorial",year)) %>%
  mutate(iso3c = countrycode(gcp$country, "country.name", destination = "iso3c"))

write_csv(gcp, "co2.csv", na="")