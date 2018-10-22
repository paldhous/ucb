# Data

Click on the title links to download the data. Place on your desktop, then double-click to unzip.

These files are in CSV format, which stands for comma-separated values; they have a `.csv` extension. These are plain text files, in which columns in the data are separated by commas. CSV is a common format for storing and exchanging data. Values that are intended to be treated as text, rather than numbers, are often enclosed in quote marks.


#### [Oakland: Injury traffic collisions](./data/oakland.zip)

Data from the [Transportation Injury Mapping System](https://tims.berkeley.edu/), which details injury and fatal traffic accidents recorded in the California Highway Patrol's [Statewide Integrated Traffic Records System](http://iswitrs.chp.ca.gov/Reports/jsp/userLogin.jsp), geocoded for mapping by UC Berkeley's Safe Transportation Research & Education Center.

`oakland_collisions.csv` Data for Oakland from 2010 to 2015, with the following variables:

 - `CASE_ID` Unique identifying code for each collision.
 - `ACCIDENT_YEAR` Year of accident.
 - `INTERSECTION` Did the collision happen at an intersection? `Y` yes, `N` no, or blank.
 - `COLLISION_DATE` Date of accident, in the international standard format `YYYY-MM-DD`.
 - `COLLISION_TIME` Time of accident, on 24-hour clock; `0915` is 9:15am, `22:20` is 10.20pm, and so on.
 - `DAY_OF_WEEK` Numbered day of the week on which collision happened; `1` is Monday, `7` is Sunday.
 - `PRIMARY_RD` The road on which the collision happened.
 - `SECONDARY_RD` The nearest cross street.
 - `NUMBER_KILLED` Number of people killed in the collision.
 - `NUMBER_INJURED` Number of people injured in the collision.
 - `HIT_AND_RUN` `F` felony hit-and-run; `M` misdemeanor hit-and-run; `N` Not a hit-and run.
 - `PEDESTRIAN_ACCIDENT` `Y` yes, or blank.
 - `BICYCLE_ACCIDENT` `Y` yes, or blank.
 - `MOTORCYCLE_ACCIDENT` `Y` yes, or blank.
 - `ALCOHOL_INVOLVED` `Y` yes, or blank.
 - `COUNT_PED_KILLED`  Number of cylists killed.
 - `COUNT_PED_INJURED` Number of cylists injured.
 - `COUNT_BICYCLIST_KILLED` Number of cylists killed.
 - `COUNT_BICYCLIST_INJURED` Number of cylists injured.
 - `COUNT_MC_KILLED` Number of motorcylists killed.
 - `COUNT_MC_INJURED` Number of motorcylists injured.
 - `COUNTY` 
 - `CITY` 
 - `POINT_X` Longitude.
 - `POINT_Y` Latitude.

#### [Richmond: Injury traffic collisions](./data/richmond.zip)

`richmond_collisions.csv` As above, but data for Richmond from 2007 to 2015.

#### [Health: Immunization in California kindergartens](./data/health.zip)

Data on immunization in kindergartens from the [California Department of Public Health](http://www.shotsforschool.org/k-12/reporting-data/).

`shots_kindergartens.csv` Data for each school, from the 2011-12 school year to the 2015-16 school year, with the following variables:
 - `district` School district.
 - `sch_code` Unique identifying code for each school.
 - `county` 
 - `pub_priv` `Public` or `Private` school.
 - `school` School name.
 - `enrollment` Number of children enrolled.
 - `complete` Number of children with all required immunizations.
 - `condit` Nimber of children enrolled who do not have an exemption but have not yet completed required immunizations.
 - `pme` Number of children with a medical exemption from required immunizations.
 - `pbe` Number of children with a personal belief exemption from required immunizations.
 - `prejan_pbe` For the `2014-15` school year, number of children with a personal belief exemption obtained prior to January 1, 2014, where a parent signed an affidavit requesting the exemption.
 - `doc_couns_pbe` Number of children with a personal belief exemption from required immunizations after counselling from health care professional.
 - `relig_pbe` Number of children with a religious belief exemption from required immunizations.
 - `dtp` Number of children immunized against diptheria, tetanus, and pertussis.
 - `polio` Number of children immunized against polio.
 - `mmr` Number of children immunized against measles, mumps, and rubella.
 - `hepb` Number of children immunized against hepatitis B.
 - `vari`  Number of children immunized against varicella-zoster virus (chicken pox).
 - `reported` Did the school report its immunization data? `Y` yes or `N` no.
 - `year` School year, `2011-12`, `2012-13`, and so on.
 - `start_year` First calendar year from the above.
 - `city`
 - `overdue` For the `2015-16` school year, number of children excluded from school because immunizations are overdue.

`shots_counties.csv` Data for each county, from the 2001-02 school year to the 2017-18 school year, with the following variables, as above:
 - `county`
 - `start_year`
 - `year`
 - `enrollment`
 - `dtp`
 - `polio`
 - `mmr`
 - `hepb`
 - `vari`



#### [Other Side of the Tech Boom: Income, poverty,  and rent for Bay Area zip codes](./data/census_rent.zip)

Data from the U.S. Census Bureau's [American Community Survey](https://www.census.gov/programs-surveys/acs/) and [Zillow Research](https://www.zillow.com/research/data/). For the ACS data, margins of error are 90% confidence intervals.

`census_rent.csv`

 - `zip` Zip code.
 - `year` For the ACS data, i.e. all variables except `rent_index` the data is summarized from five years of the survey; i.e. data is from `2012-16` where year is `2016`, and so on.
 - `city` 
 - `median_income` Median household income, in dollars.
 - `median_income_moe` Margin of error for the above.
 - `households` Number of households.
 - `households_moe` Margin of error for the above.
 - `households_poverty` Number of households in poverty.
 - `households_poverty_moe` Margin of error for the above.
 - `rent_index` Zillow Rent Index: Median estimated market rent for all property types in the zip code.



