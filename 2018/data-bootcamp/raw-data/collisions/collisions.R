# load required packages
library(dplyr)
library(readr)

# select variables
# richmond_collisions <- read_csv("richmond_collisions_raw.csv")
# vars <- data_frame(variable=names(richmond_collisions))
# write_csv(vars,"vars.csv",na="")

vars <- c("CASE_ID","ACCIDENT_YEAR","COLLISION_DATE","INTERSECTION","COLLISION_TIME","DAY_OF_WEEK","PRIMARY_RD","SECONDARY_RD","NUMBER_KILLED","NUMBER_INJURED","HIT_AND_RUN","PEDESTRIAN_ACCIDENT","BICYCLE_ACCIDENT","MOTORCYCLE_ACCIDENT","ALCOHOL_INVOLVED","COUNT_PED_KILLED","COUNT_PED_INJURED","COUNT_BICYCLIST_KILLED","COUNT_BICYCLIST_INJURED","COUNT_MC_KILLED","COUNT_MC_INJURED","COUNTY","CITY","POINT_X","POINT_Y")

# load and clean richmond collisions data
richmond_collisions <- read_csv("richmond_collisions_raw.csv") %>%
  mutate(POINT_X = case_when(POINT_X == 0 | is.na(POINT_X) ~ LATITUDE,
                             POINT_X < 0 ~ POINT_X),
         POINT_Y = case_when(POINT_Y == 0 | is.na(POINT_Y) ~ LONGITUDE,
                             POINT_Y > 0 ~ POINT_Y),
         POINT_X = round(POINT_X,5),
         POINT_Y = round(POINT_Y,5),
         CASE_ID = as.character(CASE_ID)) %>%
  select(-LATITUDE,-LONGITUDE)

# reduce number of variables
richmond_collisions_edit <- richmond_collisions %>%
  select(!!vars)

write.csv(richmond_collisions_edit, "richmond_collisions.csv", na="", row.names = F)
write.csv(richmond_collisions, "richmond_collisions_full.csv", na="", row.names = F)


# load and clean oakland collisions data
oakland_collisions <- read_csv("oakland_collisions_raw.csv", col_types = cols(
  LATITUDE = col_double(),
  LONGITUDE = col_double()
)) %>%
  mutate(POINT_X = case_when(POINT_X == 0 | is.na(POINT_X) ~ LATITUDE,
                             POINT_X < 0 ~ POINT_X),
         POINT_Y = case_when(POINT_Y == 0 | is.na(POINT_Y) ~ LONGITUDE,
                             POINT_Y > 0 ~ POINT_Y),
         POINT_X = round(POINT_X,5),
         POINT_Y = round(POINT_Y,5),
         CASE_ID = as.character(CASE_ID)) %>%
  select(-LATITUDE,-LONGITUDE) %>%
  filter(ACCIDENT_YEAR >= 2010)

oakland_collisions_edit <- oakland_collisions %>%
  select(!!vars)

write.csv(oakland_collisions, "oakland_collisions_full.csv", na="", row.names = F)
write.csv(oakland_collisions_edit, "oakland_collisions.csv", na="", row.names = F)


