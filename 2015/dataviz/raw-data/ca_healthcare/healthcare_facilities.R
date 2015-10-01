# load required libraries
library(dplyr)
library(rgdal)

# set working directory
setwd("~/Dropbox/ucb/2015/dataviz/raw-data/ca_healthcare")

# Week 8

# Import and process raw and geocoded data
healthcare_facilities_geocoded <- read.delim("healthcare_facilities_geocoded.tsv", stringsAsFactors=FALSE)
healthcare_facilities <- read.csv("healthcare_facilities_raw.csv", stringsAsFactors=FALSE)

working <- inner_join(healthcare_facilities,healthcare_facilities_geocoded) %>%
  mutate(LATITUDE=bing_latitude, LONGITUDE=bing_longitude) %>%
  select(1:23)

working2 <- anti_join(healthcare_facilities,healthcare_facilities_geocoded)

healthcare_facilities_edit <- rbind(working,working2)

# write to file
write.csv(healthcare_facilities_edit,"healthcare_facilities.csv", row.names = FALSE, na="")

# filter for hospitals and nursing facilities
hospitals <- healthcare_facilities_edit %>%
  filter(TYPE=="SKILLED NURSING FACILITY" | TYPE=="GENERAL ACUTE CARE HOSPITAL")

# write to file
write.csv(hospitals,"hospitals.csv", row.names = FALSE, na="")

# Week 9

# import gridded data from Week 8 exercise
hospitals_grid <- readOGR("hospitals_grid.GeoJSON", layer = "OGRGeoJSON")

# change data types
hospitals_grid$PNTCNT <- as.integer(hospitals_grid$PNTCNT)
hospitals_grid$CAPACITY_s <- as.integer(hospitals_grid$CAPACITY_s)

# subset to remove cells with null values
hospitals_grid <- subset(hospitals_grid, !(is.na(PNTCNT)))

# write to shapefile
writeOGR(hospitals_grid, ".", "hospitals_grid", driver="ESRI Shapefile")




