# load required packages
library(rgdal)
library(rgeos)
library(dplyr)
library(raster)
library(WDI)
library(readr)

############### 
# GDP per capita data

gdp_pc <- WDI(indicator="NY.GDP.PCAP.PP.CD", country="all", start=2015, end=2015, extra=TRUE) %>%
  filter(income != "Aggregates") %>%
  select(2,5,3) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD)
gdp_pc[is.na(gdp_pc)] <- -99 

write_csv(gdp_pc,"gdp_pc.csv",na="")

###############
# seismic risk data

# read and reproject central and eastern us
ce <- readOGR("CEUS_ProbDamageAvg","CEUS_ProbDamageAvg")
ce <- spTransform(ce, CRS( "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" ) ) 
ce@proj4string

# read and reproject western us
w <- readOGR("WUS_ProbDamageAvg","WUS_ProbDamageAvg")
w <- spTransform(w, CRS( "+proj=longlat +datum=WGS84 +no_defs +ellps=WGS84 +towgs84=0,0,0" ) ) 
w@proj4string

# combine 
us <- rbind(w, ce, makeUniqueIDs = TRUE)  

# write to shapefile
writeOGR(us, "seismic_raw", "seismic_raw", driver="ESRI Shapefile")

# import world countries 
countries <- readOGR("ne_50m_admin_0_countries_lakes", "ne_50m_admin_0_countries_lakes")
countries@proj4string

# select just US as clip layer
clip <- countries [which(countries@data$name == "United States"),]

# clip
us_clip <- raster::intersect(us,clip)
us_clip@data <- us_clip@data %>%
  dplyr::select(1)
View(us_clip@data)

us_clip@data$ValueRange <- gsub("10-12", "10 - 12", us_clip@data$ValueRange)

# write to shapefile
writeOGR(us_clip, "seismic", "seismic", driver="ESRI Shapefile")





