# Datasets

Click on the title links to download the data. Please [contact me](mailto:peter@peteraldhous.com) **before the class** in which data will be used if you have any problems downloading!

## Class exercises

#### [Download Week 1](./data/week1.zip)

- `mlb_salaries_2015.csv` Salaries of players in Major League Baseball at the start of the 2015 season, from the [Lahman Baseball Database](http://www.seanlahman.com/baseball-archive/statistics/).

- `disease_democ.csv` Data illustrating a [controversial theory](http://www.newscientist.com/article/mg21028133.300-genes-germs-and-the-origins-of-politics.html) suggesting that the emergence of democratic political systems has depended largely on nations having low rates of infectious disease, from the [Global Infectious Diseases and Epidemiology Network](http://www.gideononline.com/) and *[Democratization: A Comparative Analysis of 170 Countries](http://www.amazon.com/Democratization-Comparative-Analysis-Countries-Routledge/dp/0415318602)*.

- `gdp_pc_2015.csv` [World Bank data](http://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) on 2015 Gross Domestic Product (GDP) per capita for the world's nations, in current international dollars, corrected for purchasing power in different territories.

#### [Download Week 3](./data/week3.zip)

- `nations.csv` Data from the [World Bank Indicators](http://data.worldbank.org/indicator/all) portal, which is an incredibly rich resource. Contains the following fields:
 -  `iso2c` `iso3c` Two- and Three-letter [codes](http://www.nationsonline.org/oneworld/country_code_list.htm) for each country, assigned by the [International Organization for Standardization](http://www.iso.org/iso/home/store/catalogue_tc/catalogue_detail.htm?csnumber=63545).
 - `country` Country name.
 - `year`
 - `population` Estimated [total population](http://data.worldbank.org/indicator/SP.POP.TOTL) at mid-year, including all residents apart from refugees.
 - `gdp_percap` [Gross Domestic Product per capita](http://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) in current international dollars, corrected for purchasing power in different territories.
 - `life_expect` [Life expectancy at birth](http://data.worldbank.org/indicator/SP.DYN.LE00.IN), in years.
 - `population` Estimated [total population](http://data.worldbank.org/indicator/SP.POP.TOTL) at mid-year, including all residents apart from refugees.
 - `birth_rate` [Live births during the year per 1,000 people](http://data.worldbank.org/indicator/SP.DYN.CBRT.IN), based on mid-year population estimate.
 - `neonat_mortal_rate` [Neonatal mortality rate](http://data.worldbank.org/indicator/SH.DYN.NMRT): babies dying before reaching 28 days of age, per 1,000 live births in a given year.
 - `region` `income` World Bank [regions and income groups](http://siteresources.worldbank.org/DATASTATISTICS/Resources/CLASS.XLS), explained [here](http://data.worldbank.org/about/country-and-lending-groups).

#### [Download Week 4](./data/week4.zip)

- `index.html` `index2.html` Two simple webpages, which we will edit and publish on GitHub.

#### [Download Week 5](./data/week5.zip)

- `oil_production.csv` Data on oil production by world region from 2000 to 2016, in thousands of barrels per day, from the [U.S. Energy Information Administration](https://www.eia.gov/beta/international/data/browser/#/?pa=0000000000000000000000000000000000g&c=ruvvvvvfvtvnvv1urvvvvfvvvvvvfvvvou20evvvvvvvvvnvvuvo&ct=0&tl_id=5-A&vs=INTL.53-1-AFG-TBPD.A&vo=0&v=H&start=1980&end=2016).

- `ucb_stanford_2014.csv` Data on federal government grants to UC Berkeley and Stanford University in 2014, downloaded from [USASpending.gov](https://www.usaspending.gov/Pages/Default.aspx).

- `ny.txt` file scraped from State of New York site documenting disciplinary actions against doctors.

- `NY.html` web page with a table giving links to pages documenting individual disciplinary actions against New York doctors.

#### [Download Week 6](./data/week6.zip)

- `nations.csv` As for week 3, but lacking data for life expectancy.

#### [Download Week 7](./data/week7.zip)

- `pfizer.csv` Payments made by Pfizer to doctors across the United States in the second half on 2009. Contains the following variables:
 - `org_indiv` Full name of the doctor, or their organization.
 - `first_plus` Doctor's first and middle names.
 - `first_name` `last_name`. First and last names.
 - `city` `state` City and state.
 - `category of payment` Type of payment, which include `Expert-led Forums`, in which doctors lecture their peers on using Pfizer's drugs, and `Professional Advising.
 - `cash` Value of payments made in cash.
 - `other` Value of payments made in-kind, for example puschase of meals.
 - `total` value of payment, whether cash or in-kind.

- `fda.csv` Data on warning letters sent to doctors by the U.S. Food and Drug Administration, because of problems in the way in which they ran clinical trials testing experimental treatments. Contains the following variables:
 - `name_last` `name_first` `name_middle` Doctor's last, first, and middle names.
 - `issued` Date letter was sent.
 - `office` Office within the FDA that sent the letter.

#### [Download Week 8](./data/week8.zip)

- `disease_democ.csv` Data illustrating a controversial theory suggesting that the emergence of democratic political systems has depended largely on nations having low rates of infectious disease, from the [Global Infectious Diseases and Epidemiology Network](http://www.gideononline.com/) and *[Democratization: A Comparative Analysis of 170 Countries](http://www.amazon.com/Democratization-Comparative-Analysis-Countries-Routledge/dp/0415318602)*, as used in week 1.
- `food_stamps.csv` [U.S. Department of Agriculture data](http://www.fns.usda.gov/pd/supplemental-nutrition-assistance-program-snap) on the number of `participants`, in millions, and `costs`, in $ billions, of the federal Supplemental Nutrition Assistance Program from 1969 to 2016.
- `kindergarten.csv` Data from the [California Department of Public Health](https://data.chhs.ca.gov/dataset/school-immunizations-in-kindergarten-by-academic-year), documenting enrollment and the number of children with complete immunizations at entry into kindergartens in California from 2001 to 2015. Contains the following variables:
  - `district` School district.
  - `sch_code` Unique identifying code for each school.
  - `pub_priv` Whether school is public or private.
  - `school` School name.
  - `enrollment` Number of children enrolled.
  - `complete` Number of children with complete immunizations.
  - `start_year` Year of entry (for the 2015-2016 school year, for example, this would be 2015).
- `nations.csv` Data from World Bank World Development Indicators portal, giving data on population, GDP per capita, life expectancy, birth rate, neonatal mortality rate, region and income group for the world's nations, from 1990 onwards, as used in week 3.

#### [Download Week 9](./data/week9.zip)

- `sf_test_addresses.tsv` Text file with list of 100 addresses in San Francisco, for geocoding exercise.
- `refine_geocoder.json` JSON file to geocode using Open Refine.
- `sf_test_addresses_short.tsv` The first 10 addresses from the previous file.

#### [Download Week 10](./data/week10.zip)



- `seismic` Shapefile with data on the risk of a damaging earthquake in 2017 for the continental United States, from the [U.S. Geological Survey](https://earthquake.usgs.gov/hazards/induced/).
- `seismic_raw` As above, but not clipped to the coast and borders of the United States.
- `gdp_pc`
 - `gpd_pc.csv` `gdp_pc.csvt` CSV file with [World Bank data](http://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) on GDP per capita for the world's nations in 2015, plus ancillary file for QGIS to understand the data types for each field.
- `ne_50m_admin_0_countries_lakes` [Natural Earth shapefile](http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/) with boundary data for the world's nations.
- `sf_test_addresses` Shapefile derived from the addresses we geocoded in week 9.
- `quakes.csv` This file isn't in the folder. Instead, we will
use the U.S. Geological Survey's [Earthquakes Archives](https://earthquake.usgs.gov/earthquakes/search/) API where we will search for all earthquakes since 1960 with a [magnitude](http://www.geo.mtu.edu/UPSeis/magnitude.html) of 6 or greater that occured witin 6,000 kilometers of the geographic center of the contiguous United States, which [this site](https://tools.wmflabs.org/geohack/geohack.php?pagename=Geographic_center_of_the_contiguous_United_States&params=39.828175_N_98.579500_W_region:US_type:landmark) tells us lies at a latitude of `39.828175` degrees and a longitude of `-98.5795` degrees. Type this url into the address bar of your browser:
```Javascript
https://earthquake.usgs.gov/fdsnws/event/1/query?starttime=1960-01-01T00:00:00&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&minmagnitude=6&format=csv&orderby=time
```
A file called `query.csv` should download. Rename it `quakes.csv` and add to the `week10` folder.


#### [Download Week 11](./data/week11.zip)

Download the data from this session from [here](data/week11.zip), unzip the folder and place it on your desktop. It contains the following folders and files:

- `seismic.zip` Zipped shapefile with data on the risk of a damaging earthquake in 2017 for the continental United States, from the [U.S. Geological Survey](https://earthquake.usgs.gov/hazards/induced/).
- `seismic_raw.zip` As above, but not clipped to the coast and borders of the United States.
- `ne_50m_admin_0_countries_lakes.zip` Zipped [Natural Earth shapefile](http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/) with boundary data for the world's nations.
- `sf_test_addresses.zip` Zipped shapefile of addresses we geocoded in week 9, with their coordinates derived from Bing Maps.
- `quakes.csv` This file isn't in the folder. As for week 10, we will use the U.S. Geological Survey's [Earthquakes Archives](https://earthquake.usgs.gov/earthquakes/search/) API where we will search for all earthquakes since 1960 with a [magnitude](http://www.geo.mtu.edu/UPSeis/magnitude.html) of 6 or greater that occured witin 6,000 kilometers of the geographic center of the contiguous United States. Type this url into the address bar of your browser:
```Javascript
https://earthquake.usgs.gov/fdsnws/event/1/query?starttime=1960-01-01T00:00:00&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&minmagnitude=6&format=csv&orderby=time
```
A file called `query.csv` should download. Rename it `quakes.csv` and add to the `week11` folder.
- `test.html` A web page for embedding the Carto map we will make.

## Final projects

These datasets are suggestions, in which there are definitely stories to be found and visualized. But you are encouraged to work on other datasets.

#### [Baseball statistics](http://www.seanlahman.com/baseball-archive/statistics/?wpmp_switcher=mobile)

[Lahman's Baseball Database](http://www.seanlahman.com/baseball-archive/statistics/?wpmp_switcher=mobile) contains a wealth of data on players, managers and teams from 1871 to 2015. Download the data in a series of CSV files from [here](http://seanlahman.com/files/database/baseballdatabank-master_2016-03-02.zip).

[This file](http://seanlahman.com/files/database/readme2014.txt) documents the tables and fields, and how the tables should be joined together. For the player tables ```playerID``` is the unique code for each player that can be used to make joins.

The Lahman database is also available as an [R package](https://cran.r-project.org/web/packages/Lahman/Lahman.pdf).

```R
# install Lahman package
install.packages("Lahman")

# load the Lahman package
library(Lahman)

# view, for example, the Master table
View(Master)
```

Although you will not see them as objects in your `Environment` tab in RStudio, each of the tables in the database is now available as a data frame. If you wish, you can convert them into objects in your local environment with the following code:

```R
master <- Master
```
You can use the [dplyr](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf) package to join, filter and aggregate the data as required.

#### [North Atlantic storms](./data/storms.zip)

The file `storms.csv` contains [data on tropical storms and hurricanes](http://www.aoml.noaa.gov/hrd/hurdat/Data_Storm.html) compiled by the Hurricane Research Division of the U.S. National Oceanic and Atmospheric Administration. I have processed the [raw data](http://www.aoml.noaa.gov/hrd/hurdat/hurdat2-1851-2016-apr2017.txt) to give the following fields:
- `name` Official name for each storm; unnamed storms are listed as `Unnamed` and also numbered.
- `year` `month` `day` `hour` `minute` Date and time fields for each observation. For recent storms, observations are recorded every six hours.
- `timestamp` Date and time fields combined into a full timestamp for each observation in standard `YYYY-MM-DD HH:MM` format.
- `record_ident` The entry `L` indicates the time at which a storm made landfall, defined as the center of the system crossing a coastline, recorded from 1991 onwards. Other entries are explained in the file `newhurdat-format.pdf`.
- `status` Options include `HU` for hurricane, `TS` for tropical storm and `TD` for tropical depression. Other entries are explained in `newhurdat-format.pdf`.
- `latitude` `longitude` Geographic coordinates for the center of the system at each observation.
-  `max_wind_kts` `max_wind_kph` `max_wind_mph` Maximum sustained wind for each observation.
- `min_press` Minimum air pressure at the center of the system for each observation.

This file contains data on storms from 1851 to 2016. However, you may wish to restrict your visualizations to storms from 1990 and later, as data on storms before the modern satellite era is less reliable.

This collection of data is good for mapping. If you need shapefiles for context and basemaps, try [Natural Earth](http://www.naturalearthdata.com/downloads/). These shapefiles each come with a `README.html` file that can be opened in a web browser for more information.


#### [Wealth and well-being of nations](./data/nations.zip)

In its [World Development Indicators](http://data.worldbank.org/indicator/all), the World Bank has a trove of data on many aspects of countries' wealth and well-being: There are many stories to be told from this data.

You can download data for individual indicators, or read data directly into R using the [WDI](https://cran.r-project.org/web/packages/WDI/WDI.pdf) package. (Remember that you will need to convert data you download from the World Bank site from wide to long format; the R package will give you data in the correct long format.)

In week 5, we saw how to download Gapminder data in bulk. Its data library includes some measures not available from the World Bank, so if you cannot find the data you want among the World Bank Indicators, try searching for it at [Gapminder's data download](http://www.gapminder.org/data/) page.


#### [Global Terrorism Database](http://www.start.umd.edu/gtd/)

Maintained by the National Consortium for the Study of Terrorism and Responses to Terrorism (START) at the University of Maryland in College Park, the [Global Terrorism Database](http://www.start.umd.edu/gtd/) contains information on more than 170,000 terrorist attacks from 1970 to 2016. It is a rich source of information on terrorist groups across the globe, and the attacks they are responsible for.

You can download the data [from here](http://www.start.umd.edu/gtd/contact/), selecting the `Download full GTD dataset` option. An [extensive codebook](http://www.start.umd.edu/gtd/downloads/Codebook.pdf) details all of the fields in the data.

The data is provided as a series of spreadsheets in `.xlsx` format. I suggest that you import this data into Open Refine before processing any further, and create a new field giving the date of each event in standard `YYYY-MM-DD` format. This can be done from the `eventid` field. I can help with this.

You can then export as a CSV for analysis, visualization, and mapping.

Do read the [Terms of Use](http://www.start.umd.edu/gtd/terms-of-use/) and [instructions for citing the source](http://www.start.umd.edu/gtd/terms-of-use/CitingGTD.aspx) of the GTD data.


#### [California traffic accidents](http://tims.berkeley.edu/)

The [Transportation Injury Mapping System](http://tims.berkeley.edu/page.php?page=about) details injury and fatal traffic accidents for the whole of California. The data comes from the California Highway Patrol's [Statewide Integrated Traffic Records System](http://iswitrs.chp.ca.gov/Reports/jsp/userLogin.jsp) and was then geocoded for mapping by UC Berkeley's Safe Transportation Research & Education Center.

You will need to create an account. I can help if you have problems querying and downloading data,.

The [codebook](./data/SWITRS_codebook.pdf) explains the fields in these tables, and how they should be joined.

