# Datasets

Click on the title links to download the data. Please [contact me](mailto:p.aldhous@gmail.com) **before the class** in which data will be used if you have any problems downloading!

## Class exercises

#### [Download Week 1](./data/week1.zip)

- `mlb_salaries_2016.csv` Salaries of players in Major League Baseball at the start of the 2016 season, from the [Lahman Baseball Database](http://www.seanlahman.com/baseball-archive/statistics/).

- `disease_democ.csv` Data illustrating a [controversial theory](https://www.newscientist.com/article/mg21028133.300-genes-germs-and-the-origins-of-politics.html) suggesting that the emergence of democratic political systems has depended largely on nations having low rates of infectious disease, from the [Global Infectious Diseases and Epidemiology Network](https://www.gideononline.com/) and *[Democratization: A Comparative Analysis of 170 Countries](https://www.amazon.com/Democratization-Comparative-Analysis-Countries-Routledge/dp/0415318602)*.

- `life_wealth_2016.csv` World Bank data from 2016 on [Gross Domestic Product (GDP) per capita](https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) for the world's nations, in current international dollars, corrected for purchasing power in different territories, and [life expectancy at birth](https://data.worldbank.org/indicator/SP.DYN.LE00.IN).


#### [Download Week 3](./data/week3.zip)


#### [Download Week 4](./data/week4.zip)


#### [Download Week 5](./data/week5.zip)


#### [Download Week 6](./data/week6.zip)


#### [Download Week 7](./data/week7.zip)


#### [Download Week 8](./data/week8.zip)


#### [Download Week 9](./data/week9.zip)


#### [Download Week 10](./data/week10.zip)

#### [Download Week 11](./data/week11.zip)

#### [Download Week 13](./data/week13.zip)

#### [Download Week 14](./data/week14.zip)



## Final projects

These datasets are suggestions, in which there are definitely stories to be found and visualized. But you are encouraged to work on other datasets.

#### [Baseball statistics](http://www.seanlahman.com/baseball-archive/statistics/?wpmp_switcher=mobile)

[Lahman's Baseball Database](http://www.seanlahman.com/baseball-archive/statistics/?wpmp_switcher=mobile) contains a wealth of data on players, managers and teams from 1871 to 2015. Download the data in a series of CSV files from [here](http://seanlahman.com/files/database/baseballdatabank-master_2018-03-28.zip).

[This file](http://www.seanlahman.com/files/database/readme2017.txt) documents the tables and fields, and how the tables should be joined together. For the player tables `playerID` is the unique code for each player that can be used to make joins.

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

#### [Download North Atlantic storms](./data/storms.zip)

The file `storms.csv` contains [data on tropical storms and hurricanes](http://www.aoml.noaa.gov/hrd/hurdat/Data_Storm.html) compiled by the Hurricane Research Division of the U.S. National Oceanic and Atmospheric Administration. I have processed the [raw data](http://www.aoml.noaa.gov/hrd/hurdat/hurdat2.html) to give the following fields:
- `name` Official name for each storm; unnamed storms are listed as `Unnamed` and also numbered.
- `year` `month` `day` `hour` `minute` Date and time fields for each observation. For recent storms, observations are recorded every six hours.
- `timestamp` Date and time fields combined into a full timestamp for each observation in standard `YYYY-MM-DD HH:MM` format.
- `record_ident` The entry `L` indicates the time at which a storm made landfall, defined as the center of the system crossing a coastline, recorded from 1991 onwards. Other entries are explained in the file `newhurdat-format.pdf`.
- `status` Options include `HU` for hurricane, `TS` for tropical storm and `TD` for tropical depression. Other entries are explained in `newhurdat-format.pdf`.
- `latitude` `longitude` Geographic coordinates for the center of the system at each observation.
-  `max_wind_kts` `max_wind_kph` `max_wind_mph` Maximum sustained wind for each observation.
- `min_press` Minimum air pressure at the center of the system for each observation.

This file contains data on storms from 1851 to 2017. However, you may wish to restrict your visualizations to storms from 1990 and later, as data on storms before the modern satellite era is less reliable.

This collection of data is good for mapping. If you need shapefiles for context and basemaps, try [Natural Earth](https://www.naturalearthdata.com/downloads/). These shapefiles each come with a `README.html` file that can be opened in a web browser for more information.


#### [Wealth and well-being of nations](./data/nations.zip)

In its [World Development Indicators](https://data.worldbank.org/indicator/?tab=all), the World Bank has a trove of data on many aspects of countries' wealth and well-being: There are many stories to be told from this data.

You can download data for individual indicators, or read data directly into R using the [WDI](https://cran.r-project.org/web/packages/WDI/WDI.pdf) package. (Remember that you will need to convert data you download from the World Bank site from wide to long format; the R package will give you data in the correct long format.)

In week 5, we saw how to download Gapminder data in bulk. Its data library includes some measures not available from the World Bank, so if you cannot find the data you want among the World Bank Indicators, try searching for it at [Gapminder's data download](https://www.gapminder.org/data/) page.


#### [Global Terrorism Database](http://www.start.umd.edu/gtd/)

Maintained by the National Consortium for the Study of Terrorism and Responses to Terrorism (START) at the University of Maryland in College Park, the [Global Terrorism Database](https://www.start.umd.edu/gtd/) contains information on more than 170,000 terrorist attacks from 1970 to 2016. It is a rich source of information on terrorist groups across the globe, and the attacks they are responsible for.

You can download the data [from here](https://www.start.umd.edu/gtd/contact/), selecting the `Download full GTD dataset` option. An [extensive codebook](https://www.start.umd.edu/gtd/downloads/Codebook.pdf) details all of the fields in the data.

The data is provided as a series of spreadsheets in `.xlsx` format. I suggest that you import this data into Open Refine before processing any further, and create a new field giving the date of each event in standard `YYYY-MM-DD` format. This can be done from the `eventid` field. I can help with this.

You can then export as a CSV for analysis, visualization, and mapping.

Do read the [Terms of Use](https://www.start.umd.edu/gtd/terms-of-use/) and [instructions for citing the source](https://www.start.umd.edu/gtd/terms-of-use/CitingGTD.aspx) of the GTD data.


#### [California traffic accidents](http://tims.berkeley.edu/)

The [Transportation Injury Mapping System](https://tims.berkeley.edu/) details injury and fatal traffic accidents for the whole of California. The data comes from the California Highway Patrol's [Statewide Integrated Traffic Records System](http://iswitrs.chp.ca.gov/Reports/jsp/userLogin.jsp) and was then geocoded for mapping by UC Berkeley's Safe Transportation Research & Education Center.

You will need to create an account. I can help if you have problems querying and downloading data,.

The [codebook](./data/SWITRS_codebook.pdf) explains the fields in these tables, and how they should be joined.

