library(dplyr)

setwd("~/Dropbox/ucb/2015/dataviz/raw-data/ca_healthcare")

healthcare_facilities_geocoded <- read.delim("healthcare_facilities_geocoded.tsv", stringsAsFactors=FALSE)
healthcare_facilities <- read.csv("healthcare_facilities_raw.csv", stringsAsFactors=FALSE)

working <- inner_join(healthcare_facilities,healthcare_facilities_geocoded) %>%
  mutate(LATITUDE=bing_latitude, LONGITUDE=bing_longitude) %>%
  select(1:23)

working2 <- anti_join(healthcare_facilities,healthcare_facilities_geocoded)

healthcare_facilities_edit <- rbind(working,working2)

write.csv(healthcare_facilities_edit,"healthcare_facilities.csv", row.names = FALSE, na="")

