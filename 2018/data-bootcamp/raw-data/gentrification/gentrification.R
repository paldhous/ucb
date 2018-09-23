# load required packages
library(dplyr)
library(readr)
library(tidyr)
library(tidycensus)
library(censusapi)
library(ggplot2)
library(scales)

# load bay area zip codes
# from https://catalog.data.gov/dataset/bay-area-zip-codes/resource/6cacd1a1-6bff-4c7c-9094-49188ea29f85
zips <- read_csv("bayarea_zipcodes.csv") %>%
  select(city = PO_NAME, zip = ZIP) %>%
  mutate(zip = as.character(zip))

years <- c(2011:2016)

# censusapi version
Sys.setenv(CENSUS_KEY="f6811bb29b8f3f4de930ececf654c6d0ebe6c7be")

apis <- listCensusApis()
View(apis)

acs1 <- data_frame()

# this is failing in 2012 for acs5, failing on unsupported geometry
for (y in years) {
  print(y)
  tmp <- getCensus(name = "acs/acs5", vintage = y,
                       vars = c("B19013_001E", "B19013_001M", 
                                "B11005_001E", "B11005_001M", 
                                "B11005_002E", "B11005_002M"),
                       region = "zip code tabulation area") 
  names(tmp) <- c("zip",
                  "med_income","med_income_moe",
                  "households","households_moe",
                  "households_poverty","households_poverty_moe")
  tmp <- tmp %>%
    inner_join(zips) %>%
    mutate(year=y)
  acs5 <- bind_rows(acs5,tmp)
}


# tidycensus version

census_api_key("f6811bb29b8f3f4de930ececf654c6d0ebe6c7be", install = TRUE)

v16 <- load_variables(2016, "acs5", cache = TRUE)

# median household income
income <- data_frame()
for (y in years) {
  tmp <- get_acs(geography = "zcta",
                 year = y,
                 variables = c("B19013_001")) %>%
    mutate(year = y) %>%
    rename(median_income=estimate,
           median_income_moe=moe,
           zip = GEOID) %>%
    select(zip,median_income,median_income_moe,year) %>%
    inner_join(zips)
  income <- bind_rows(income,tmp)
  rm(tmp)
}

# households
households <- data_frame()
for (y in years) {
  tmp <- get_acs(geography = "zcta",
                 year = y,
                 variables = c("B11005_001")) %>%
    mutate(year = y) %>%
    rename(households=estimate,
           households_moe=moe,
           zip = GEOID) %>%
    select(zip,households,households_moe,year) %>%
    inner_join(zips)
  households <- bind_rows(households,tmp)
  rm(tmp)
}

# households in poverty
households_poverty <- data_frame()
for (y in years) {
  tmp <- get_acs(geography = "zcta",
                 year = y,
                 variables = c("B11005_002")) %>%
    mutate(year = y) %>%
    rename(households_poverty=estimate,
           households_poverty_moe=moe,
           zip = GEOID) %>%
    select(zip,households_poverty,households_poverty_moe,year) %>%
    inner_join(zips)
  households_poverty <- bind_rows(households_poverty,tmp)
  rm(tmp)
}

# clean up workspace
rm(y)

# join
census <- inner_join(income,households, by = c("zip", "year", "city")) %>%
  inner_join(households_poverty, by = c("zip", "year", "city"))

# load zillow rent index
# from https://www.zillow.com/research/data/
zri <- read_csv("zri.csv") %>%
  select(2,11:100) %>%
  rename(zip = RegionName) %>%
  gather(month,rent_index,-zip) %>%
  separate(month, into = c("year","month"), sep = "-") %>%
  group_by(zip,year) %>%
  summarise(rent_index = round(mean(rent_index, na.rm = T))) %>%
  mutate(year = as.integer(year)) %>%
  inner_join(zips)

# final join
census_rent <- left_join(census,zri) %>%
  select(1,4,5,2,3,6:10) %>%
  arrange(city,zip,year)

# write to csv
write_csv(census_rent, "census_rent.csv", na="")


# charts
ggplot(census, aes(x=year, y=median_income, group=zip)) + 
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin=median_income-median_income_moe,ymax=median_income+median_income_moe)) +
  facet_wrap(~city, scales = "free_y") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

ggplot(census, aes(x=year, y=households_poverty, group=zip)) + 
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin=households_poverty-households_poverty_moe,ymax=households_poverty+households_poverty_moe)) +
  facet_wrap(~city, scales = "free_y") +
  scale_y_continuous(labels = comma) +
  theme_minimal()
  
ggplot(census, aes(x=year, y=households, group=zip)) + 
  geom_point() +
  geom_line() +
  geom_errorbar(aes(ymin=households-households_moe,ymax=households+households_moe)) +
  facet_wrap(~city, scales = "free_y") +
  scale_y_continuous(labels = comma) +
  theme_minimal()

ggplot(census_rent, aes(x=year, y=rent_index, group=zip)) + 
  geom_point() +
  geom_line() +
  facet_wrap(~city, scales = "free_y") +
  scale_y_continuous(labels = comma) +
  theme_minimal()




