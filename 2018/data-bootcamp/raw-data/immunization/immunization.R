# load required packages
library(dplyr)
library(readr)
library(lettercase)

# data from http://www.shotsforschool.org/k-12/reporting-data/

# read data to 2015
immun <- read_csv( "kindergarten.csv") %>%
  mutate(school = str_title_case(school))

# remove the % columns
retain <- names(immun)[!grepl("pc", names(immun))]
immun <- immun %>%
  select(!!retain)

# summarize by county
shots_county <- immun %>%
  group_by(county, start_year, year) %>%
  summarise(enrollment = sum(enrollment, na.rm=T),
            dtp = sum(dtp, na.rm=T),
            polio = sum(polio, na.rm=T),
            mmr = sum(mmr, na.rm=T),
            hepb = sum(hepb, na.rm=T),
            vari = sum(vari, na.rm=T))

# import 2016 county data for major shots
shots_county_2016 <- read_csv("kindergarten2016.csv", col_names = F) 
names(shots_county_2016) <- c("county","enrollment","dtp","polio","mmr","hepb","vari")
shots_county_2016 <- shots_county_2016 %>%
  mutate(county=str_title_case(county),
         year="2016-17",
         start_year=2016)

# import 2016 county data for major shots
shots_county_2017 <- read_csv("kindergarten2017.csv", col_names = F) 
names(shots_county_2017) <- c("county","enrollment","dtp","polio","mmr","hepb","vari")
shots_county_2017 <- shots_county_2017 %>%
  mutate(county=str_title_case(county),
         year="2017-18",
         start_year=2017)

# combine data
shots_county <- bind_rows(shots_county,shots_county_2016,shots_county_2017) %>%
  arrange(county,start_year)

# write to csv
write_csv(shots_county,"shots_county.csv", na="")
write_csv(immun, "shots_kindergartens.csv", na="")


