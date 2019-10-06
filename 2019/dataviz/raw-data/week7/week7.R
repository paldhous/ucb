# set working directory to the folder containing this script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load packages to read, write and process data
library(readr)
library(dplyr)

# load nations and carbon dioxide emissions data
nations <- read_csv("nations.csv")
co2 <- read_csv("co2.csv")

# view structure of nations data
glimpse(nations)

# print values for population in the nations data
nations$population

# convert population to numeric
nations$population <- as.numeric(nations$population)
glimpse(nations)

# summary of nations data
summary(nations)

# filter data for 2017 only, and select columns for country, life expectancy, income group, and region
longevity_2017 <- nations %>%
  filter(year == 2017 & !is.na(life_expect)) %>%
  select(country, life_expect, income, region)

# find the ten high-income countries with the shortest life expectancy in 2016
high_income_short_life <- longevity_2017 %>%
  filter(income == "High income") %>%
  arrange(life_expect) %>%
  head(10)

# find countries in North America or Europe & Central Asia with a life expectancy in 2017 of 75 - 80
eur_na_75_80 <- longevity_2017 %>%
  filter(life_expect > 75 & life_expect < 80 & (region == "Europe & Central Asia" | region == "North America")) %>%
  arrange(desc(life_expect))

# find the 20 countries with the longest life expectancies in 2017, 
# plus the United States with its rank, if it lies outside the top 20
long_life <- longevity_2017 %>%
  mutate(rank_le = rank(desc(life_expect))) %>%
  arrange(rank_le) %>%
  filter(rank_le <= 20 | country == "United States")

long_life <- nations %>%
  filter(year == 2017 & !is.na(life_expect)) %>%
  select(country, life_expect, income, region) %>%
  mutate(rank_le = rank(desc(life_expect))) %>%
  arrange(rank_le) %>%
  filter(rank_le <= 20 | country == "United States")

# find the 20 countries with the longest life expectancies,
# plus the United States and Russia with their ranks
long_life <- longevity_2017 %>%
  mutate(rank_le = rank(desc(life_expect))) %>%
  arrange(rank_le) %>%
  filter(rank_le <= 20 | grepl("United States|Russia", country))

# write data to a csv file
write_csv(long_life, "long_life.csv", na="")

# summarize the data by year, counting the number of countries for which there is data for life expectancy
longevity_year_count <- nations %>%
  filter(!is.na(life_expect)) %>%
  group_by(year) %>%
  summarize(countries = n())

# summarize the data by year, counting the number of countries for which there is data for life expectancy
longevity_year_count <- nations %>%
  filter(!is.na(life_expect)) %>%
  group_by(year) %>%
  count()

# summarize the data by year, finding the maximum and minimum country-level life expectancies, and then calculate the range of values
longevity_year_summary <- nations %>%
  filter(!is.na(life_expect)) %>%
  group_by(year) %>%
  summarize(countries = n(),
            max_life_expect = max(life_expect),
            min_life_expect = min(life_expect)) %>%
  mutate(range_life_expect = max_life_expect - min_life_expect) %>%
  arrange(desc(year))

# total GDP, in trillions of dollars, by region and year
gdp_regions_year <- nations %>%
  mutate(gdp = gdp_percap * population,
         gdp_tn = gdp/1000000000000) %>%
  group_by(region, year) %>%
  summarize(total_gdp_tn = sum(gdp_tn, na.rm = TRUE))

# join nations to co2
nations_join <- left_join(nations, co2)
nations_join2 <- inner_join(nations, co2)
nations_join3 <- inner_join(nations, co2, by = c("iso3c" = "iso3c", "year" = "year"))

# total carbon dioxide emissions, in millions of tonnes, by region and year
co2_regions_year <- nations_join3 %>%
  group_by(region, year) %>%
  summarize(total_emissions = sum(emissions, na.rm = TRUE))

# load data
immun <- read_csv("kindergarten.csv",  col_types = list(
  county = col_character(),
  district = col_character(),
  sch_code = col_character(),
  pub_priv = col_character(),
  school = col_character(),
  enrollment = col_integer(),
  complete  = col_integer(),
  start_year = col_integer()))

immun_2015 <- read_csv("kindergarten_2015.csv",  col_types = list(
  county = col_character(),
  district = col_character(),
  sch_code = col_character(),
  pub_priv = col_character(),
  school = col_character(),
  enrollment = col_integer(),
  complete  = col_integer(),
  start_year = col_integer()))

# append the 2015 data to the older data
immun <- bind_rows(immun, immun_2015)

# percentage incomplete, entire state, by year
immun_year <- immun %>%
  group_by(start_year) %>%
  summarize(enrolled = sum(enrollment, na.rm=TRUE),
            completed = sum(complete, na.rm=TRUE)) %>%
  mutate(pc_incomplete = round(((enrolled-completed)/enrolled*100),2))


# save session data
save.image("week7.RData")
