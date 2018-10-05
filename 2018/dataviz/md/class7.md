# Processing data with R

### Introducing R and RStudio

In today's class we will work with **[R](http://www.r-project.org/)**, which is a very powerful tool, designed by statisticians for data analysis. Described on its website as "free software environment for statistical computing and graphics," R is a programming language that opens a world of possibilities for making graphics and analyzing and processing data. Indeed, just about anything you may want to do with data can be done with R, from web scraping to making interactive graphics.

Our goal for today's class is to get used to processing and analyzing data using the **[dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html)** package.

**[RStudio](https://www.rstudio.com/)** is an "integrated development environment," or IDE, for R that provides a user-friendly interface.

Launch RStudio, and the screen should look like this:

![](./img/class7_1.jpg)

The main panel to the left is the R Console. It shows the version of R you are running, here `3.5.1`.

Type valid R code into here, hit `return`, and it will be run. See what happens if you run:

```R
print("Hello World!")
```

### The data we will use today

Download the data for this session from [here](data/data-processing-r.zip), unzip the folder and place it on your desktop. It contains the following files:

- `nations.csv` Data from the [World Bank Indicators](https://data.worldbank.org/indicator/) portal. Contains the following fields:
 -  `iso2c` `iso3c` Two- and Three-letter codes for each country, assigned by the [International Organization for Standardization](https://www.iso.org/standard/63545.html).
 - `country` Country name.
 - `year`
 - `population` Estimated [total population](https://data.worldbank.org/indicator/SP.POP.TOTL) at mid-year, including all residents apart from refugees.
 - `gdp_percap` [Gross Domestic Product per capita](https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) in current international dollars, corrected for purchasing power in different territories.
 - `life_expect` [Life expectancy at birth](https://data.worldbank.org/indicator/SP.DYN.LE00.IN), in years.
 - `population` Estimated [total population](https://data.worldbank.org/indicator/SP.POP.TOTL) at mid-year, including all residents apart from refugees.
 - `birth_rate` [Live births during the year per 1,000 people](https://data.worldbank.org/indicator/SP.DYN.CBRT.IN), based on mid-year population estimate.
 - `neonat_mortal_rate` [Neonatal mortality rate](https://data.worldbank.org/indicator/SH.DYN.NMRT): babies dying before reaching 28 days of age, per 1,000 live births in a given year.
 - `region` `income` World Bank [regions and income groups](https://siteresources.worldbank.org/DATASTATISTICS/Resources/CLASS.XLS), explained [here](https://datahelpdesk.worldbank.org/knowledgebase/articles/906519).

- `nations2.csv` Again from the World Bank Indicators portal. Contains the following fields:
 - `iso3c` `year` As above.
 - `co2_percap` [Carbon dioxide emissions per capita](https://data.worldbank.org/indicator/EN.ATM.CO2E.PC) metric tonnes.

- `kindergarten.csv` Data from the [California Department of Public Health](https://www.cdph.ca.gov/programs/immunize/Pages/ImmunizationLevels.aspx), documenting enrollment and the number of children with complete immunizations at entry into kindergartens in California from 2001 to 2014. Contains the following variables:
  - `district` School district.
  - `sch_code` Unique identifying code for each school.
  - `pub_priv` Whether school is public or private.
  - `school` School name.
  - `enrollment` Number of children enrolled.
  - `complete` Number of children with complete immunizations.
  - `start_year` Year of entry (for the 2014-2015 school year, for example, this would be 2014).

- `kindergarten_2015.csv` As above, but data from 2015 only.


### Reproducibility: Save your scripts

Data journalism should ideally be fully documented and reproducible. R makes this easy, as every operation performed can be saved in a script, and repeated by running that script. Click on the ![](./img/class7_2.jpg) icon at top left and select `R Script`. A new panel should now open:

![](./img/class7_3.jpg)

Any code we type in here can be run in the console. Hitting `Run` will run the line of code on which the cursor is sitting. To run multiple lines of code, highlight them and click `Run`.

Click on the save/disk icon in the script panel and save the blank script to the file on your desktop with the data for this week, calling it `week7.R`.

### Set your working directory

Now we can set the working directory to this folder by selecting from the top menu `Session>Set Working Directory>To Source File Location`. (Doing so means we can load the files in this directory without having to refer to the full path for their location, and anything we save will be written to this folder.)

Notice how this code appears in the console:

```R
setwd("~/Desktop/week7")
```

### Save your data

The panel at top right has three tabs, the first showing the `Environment`, or all of the "objects" loaded into memory for this R session. We can save this as well, so we don't have to load and process data again if we return to return to a project later.

Click on the save/disk icon in the `Environment` panel to save and call the file `week7.RData`. You should see the following code appear in the Console:

```r
save.image("~/Desktop/week7/week7RData")
```
Copy this code into your script, placing it at the end, with a comment, explaining what it does:

```r
# save session data
save.image("~/Desktop/data-processing-r/data-processing.RData")
```
Now if you run your entire script, the last action will be to save the data in your environment.

From the top menu, select `RStudio>Preferences`, and change `Save workspace to .RData on exit` to `Never`:

![](./img/class7_3a.jpg)

This change in your settings will ensure that the contents of your environment are not saved into a generic file that will load eacvh time you open RStudio.

### Comment your code

Anything that appears on a line after `#` will be treated as a comment, and will be ignored when the code is run. Use this to explain what the codes does. Get into the habit of commenting your code: Don't trust yourself to remember!

### Some R code basics

- `<-` is known as an “assignment operator.” It means: “Make the object named to the left equal to the output of the code to the right.”
- `&` means AND, in Boolean logic.
- `|` means OR, in Boolean logic.
- `!` means NOT, in Boolean logic.
- When referring to values entered as text, or to dates, put them in quote marks, like this: `"United States"`, or `"2017-07-26"`. Numbers are not quoted.
- When entering two or more values as a list, combine them using the function `c`, with the values separated by commas, for example: `c("2018-08-26","2018-09-04")`
- As in a spreadsheet, you can specify a range of values with a colon, for example: `c(1:10)` creates a list of integers (whole numbers) from one to ten.
- Some common operators:
 - `+` `-` Add, subtract.
 -  `*` `/` Multiply, divide.
 -  `>` `<` Greater than, less than.
 -  `>=` `<=` Greater than or equal to, less than or equal to.
 -  `!=` Not equal to.

- Equals signs can be a little confusing, but see how they are used in the code we use today:

 -  `==` Test whether an object is equal to a value. This is often used when filtering data, as we will see.
 -  `=` Make an object equal to a value; works like `<-`, but used within the brackets of a function.

- Handling null values:
 - Nulls are designated as `NA`.
 - `is.na(x)` looks for nulls within variable `x`.
 - `!is.na(x)` looks for non-null values within variable `x`.

Here, `is.na` is a **function**. Functions are followed by parentheses, and act on the data/code in the parenthesis.

==**Important:**== Object and variable names in R should not contain spaces.

### Install and load R packages

Much of the power of R comes from the thousands of "packages" written by its community of open source contributors. These are optimized for specific statistical, graphical or data-processing tasks. To see what packages are available in the basic distribution of R, select the `Packages` tab in the panel at bottom right. To find packages for particular tasks, try searching Google using appropriate keywords and the phrase "R package."

In this class, we will work with two incredibly useful packages developed by [Hadley Wickham](http://hadley.nz/), chief scientist at RStudio:

- **[readr](https://cran.r-project.org/web/packages/readr/readr.pdf)** Reads and writes CSV and other text files.
- **[dplyr](https://cran.r-project.org/web/packages/dplyr/dplyr.pdf)** Processes and analyzes data, using the operations we discussed in the first class.

These and several other useful packages have been combined into a super-package called the **[tidyverse](https://www.tidyverse.org/)**.

To install a package, click on the `Install` icon in the `Packages` tab, type its name into the dialog box, and make sure that `Install dependencies` is checked, as some packages will only run correctly if other packages are also installed. Click `Install` and all of the required packages should install:

![](./img/class7_4.jpg)

Notice that the following code appears in the console:

```r
install.packages("tidyverse")
```
So you can also install packages with code in this format, without using the point-and-click interface.

Each time you start R, it's a good idea to click on `Update` in the `Packages` panel to update all your installed packages to the latest versions.

Installing a package makes it available to you, but to use it in any R session you need to load it. You can do this by checking its box in the `Packages` tab. However, we will enter the following code into our script, then highlight these lines of code and run them:

```r
# load packages to read, write and process data
library(readr)
library(dplyr)
```
At this point, and at regular intervals, save your script, by clicking the save/disk icon in the script panel, or using the `⌘-S` keyboard shortcut.

### Load and view data

#### Load data

You can load data into the current R session by selecting `Import Dataset>From Text File...` in the `Environment` tab.

However, we will use the `read_csv` function from the **readr** package. Copy the following code into your script and `Run`:

```r
# load health and wealth of nations data
nations <- read_csv("nations.csv")
nations2 <- read_csv("nations2.csv")

```
Notice that the `Environment` now contains two objects, of the type `tbl_df`, a variety of the standard R object for holding tables of data, known as a **data frame**:

![](img/class7_5.jpg)

The `Value` for each data frame details the number of columns, and the number of rows, or observations, in the data.

You can remove any object from your environment by checking it in the `Grid` view and clicking the broom icon.


#### Examine the data

We can `View` data at any time by clicking on its table icon in the `Environment` tab in the `Grid` view.

The `glimpse` function will tell you more about the columns in your data, including their data type. Copy this code into your script and `Run`:

```r
# view structure of data
glimpse(nations)
```
This should give the following output in the R Console:

```JSON
Observations: 5,697
Variables: 11
$ iso2c              <chr> "AD", "AD", "AD", "AD", "AD", "AD", "AD", "AD"...
$ iso3c              <chr> "AND", "AND", "AND", "AND", "AND", "AND", "AND...
$ country            <chr> "Andorra", "Andorra", "Andorra", "Andorra", "A...
$ year               <int> 2007, 2011, 2013, 2008, 1992, 2006, 2009, 2010...
$ gdp_percap         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
$ life_expect        <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
$ population         <int> 82683, 83751, 80788, 83861, 58888, 80991, 8446...
$ birth_rate         <dbl> 10.1, NA, NA, 10.4, 12.1, 10.6, 9.9, 9.8, 10.9...
$ neonat_mortal_rate <dbl> 1.5, 1.3, 1.2, 1.4, 3.6, 1.6, 1.4, 1.3, 3.1, 3...
$ region             <chr> "Europe & Central Asia", "Europe & Central Asi...
$ income             <chr> "High income", "High income", "High income", "...
```

`chr` means "character," or a string of text (which can be treated as a categorical variable); `int` means an integer or whole number; `dbl` means a number that can contain decimal fractions.

If you run into any trouble importing data with **readr**, you may need to specify the data types for some columns -- in particular for date and time. [This link](https://github.com/hadley/readr/blob/master/vignettes/column-types.Rmd) explains how to set data types for individual variables when importing data with **readr**.

To specify an individual column use the name of the data frame and the column name, separated by `$`. Type this into your script and run:

```r
# print values for population in the nations data
nations$population
```
The output will be the first 1,000 values for that column.

If you need to change the data type for any column, use the following functions:

- `as.character` converts to a text string.
- `as.numeric` converts to a number that can include decimal fractions.
- `as.factor` converts to a categorical variable.
- `as.integer` converts to an integer.
- `as.Date` converts to a date.
- `as.POSIXct` converts to a full date and timestamp.

(To convert a date/time written as a string of text to a date or a full timestamp, you may also need to specify the format, see [here](https://www.r-bloggers.com/date-formats-in-r/) for more.)

This code will convert the population numbers from integers to numbers that could hold decimal fractions:

```r
# convert population to numeric
nations$population <- as.(nations$population)
glimpse(nations)
```
Notice that the data type for `population` has now changed:

```JSON
Observations: 5,697
Variables: 11
$ iso2c              <chr> "AD", "AD", "AD", "AD", "AD", "AD", "AD", "AD"...
$ iso3c              <chr> "AND", "AND", "AND", "AND", "AND", "AND", "AND...
$ country            <chr> "Andorra", "Andorra", "Andorra", "Andorra", "A...
$ year               <int> 2007, 2011, 2013, 2008, 1992, 2006, 2009, 2010...
$ gdp_percap         <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
$ life_expect        <dbl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
$ population         <dbl> 82683, 83751, 80788, 83861, 58888, 80991, 8446...
$ birth_rate         <dbl> 10.1, NA, NA, 10.4, 12.1, 10.6, 9.9, 9.8, 10.9...
$ neonat_mortal_rate <dbl> 1.5, 1.3, 1.2, 1.4, 3.6, 1.6, 1.4, 1.3, 3.1, 3...
$ region             <chr> "Europe & Central Asia", "Europe & Central Asi...
$ income             <chr> "High income", "High income", "High income", "...
```

The `summary` function will run a quick statistical summary of a data frame, calculating mean, median and quartile values for continuous variables:
summary` function will run a quick statistical summary of a data frame, calculating mean, median and quartile values for continuous variables:

```r
# summary of nations data
summary(nations)
```
Here is the console output:

```JSON
    iso2c              iso3c             country               year     
 Length:5697        Length:5697        Length:5697        Min.   :1990  
 Class :character   Class :character   Class :character   1st Qu.:1996  
 Mode  :character   Mode  :character   Mode  :character   Median :2003  
                                                          Mean   :2003  
                                                          3rd Qu.:2010  
                                                          Max.   :2016  
                                                                        
   gdp_percap      life_expect      population          birth_rate   
 Min.   :   242   Min.   :27.61   Min.   :9.003e+03   Min.   : 6.90  
 1st Qu.:  2338   1st Qu.:62.06   1st Qu.:7.454e+05   1st Qu.:13.23  
 Median :  6844   Median :70.70   Median :5.378e+06   Median :21.45  
 Mean   : 13530   Mean   :68.19   Mean   :3.001e+07   Mean   :23.90  
 3rd Qu.: 18154   3rd Qu.:75.39   3rd Qu.:1.796e+07   3rd Qu.:33.57  
 Max.   :140037   Max.   :85.42   Max.   :1.379e+09   Max.   :55.56  
 NA's   :779      NA's   :429     NA's   :17          NA's   :312    
 neonat_mortal_rate    region             income         
 Min.   : 0.60      Length:5697        Length:5697       
 1st Qu.: 6.00      Class :character   Class :character  
 Median :14.50      Mode  :character   Mode  :character  
 Mean   :18.92                                           
 3rd Qu.:28.70                                           
 Max.   :75.00                                           
 NA's   :567
```

### Process and analyze data with dplyr

Now we will use **dplyr** to process the data, using the basic operations we discussed in the first class:

- **Sort:** Largest to smallest, oldest to newest, alphabetical etc.

- **Filter:** Select a defined subset of the data.

- **Summarize/Aggregate:** Deriving one value from a series of other values to produce a summary statistic. Examples include: count, sum, mean, median, maximum, minimum etc. Often you'll **group** data into categories first, and then aggregate by group.

- **Join:** Merging entries from two or more datasets based on common field(s), e.g. unique ID number, last name and first name.

Here are some of the most useful functions in **dplyr**:

- `select` Choose which columns to include.
- `filter` **Filter** the data.
- `arrange` **Sort** the data, by size for continuous variables, by date, or alphabetically.
- `group_by` **Group** the data by a categorical variable.
- `summarize` **Summarize**, or aggregate (for each group if following `group_by`). Often used in conjunction with functions including:
	- `mean(x)` Calculate the mean, or average, for variable `x`.
	- `median(x)` Calculate the median.
	- `max(x)` Find the maximum value.
	- `min(x)` Find the minimum value.
	- `sum(x)` Add all the values together.
	- `n()` Count the number of records. Here there isn't a variable in the brackets of the function, because the number of records applies to all variables.
	- `n_distinct(x`) Count the number of unique values in variable `x`.
- `mutate` Create new column(s) in the data, or change existing column(s).
- `rename` Rename column(s).
- `bind_rows` Merge two or more data frames into one, combining data from columns with the same name.

There are also various functions to **join** data, which we will explore below.

These functions can be chained together using the "pipe" operator `%>%`, which makes the output of one line of code the input for the next. This allows you to run through a series of operations in a logical order. I find it helpful to think of `%>%` as meaning "then."

#### Filter and sort data

Now we will **filter** and **sort** the data in specific ways. For each of the following examples, copy the code that follows into your script, and view the results. Notice how we create new objects to hold the processed data.

##### Filter the data for 2016 only

```r
# filter data for 2016 only, and select columns for country, life expectancy, income group, and region
longevity <- nations %>%
  filter(year == 2016 & !is.na(life_expect)) %>%
  select(country, life_expect, income, region)
```
In this code, we created a new object called `longevity` from `nations` and then (`%>%`) filtered it for just the data for 2016 and to include only non-null values. Then we select just four variables from the ten in the original data frame. There should be data returned for 195 countries.

Here are the first few records in the new object:

![](img/class7_6.jpg)

##### Find the ten high-income countries with the shortest life expectancy in 2016

```r
# find the ten high-income countries with the shortest life expectancy
high_income_short_life <- longevity %>%
  filter(income == "High income") %>%
  arrange(life_expect) %>%
  head(10)
```
This code takes the previous `longevity` object, filters it for countries in the high income group only, then sorts the data, using `arrange` (the default is ascending order). Finally it uses `head(10)` to return the first ten countries in the sorted data.

##### Find countries in North America or Europe & Central Asia with a life expectancy in 2016 of between 75 and 80.

```R
# find countries in North America or Europe & Central Asia with a life expectancy in 2016 of 75 - 80
eur_na_75_80 <- longevity %>%
  filter(life_expect > 75 & life_expect < 80 & (region == "Europe & Central Asia" | region == "North America")) %>%
  arrange(desc(life_expect))
```

This should be the result:

![](img/class7_8.jpg)

Whereas in the initial filter of the data to create the `longevity` data frame we used `&` to return data meeting both criteria, this time we also used `|` to include data meeting either criteria. `&` and `|` are equivalent to `AND` and `OR` in Boolean logic. Notice how the `|` part of the filter is wrapped in parentheses. Look at what happens if you remove them, and work out what is going on.

**==Note:==** When combining `&` and `|` in more complex filters, use parentheses to determine which parts of the evaluation should be carried out first.


##### Find the 20 countries with the longest life expectancy in 2016, plus the United States with its rank, if it lies outside the top 20

```r
# find the 20 countries with the longest life expectancies, 
# plus the United States with its rank, if it lies outside the top 20
long_life <- longevity %>%
  mutate(rank_le = rank(desc(life_expect))) %>%
  arrange(rank_le) %>%
  filter(rank_le <= 20 | country == "United States")
```
This should be the result, showing the United States to rank a lowly 42nd:

![](img/class7_9.jpg)

Here we started by creating a new variable in the data called `rank_le`, using the `mutate` function from dplyr and the `rank` [function](https://www.rdocumentation.org/packages/base/versions/3.4.3/topics/rank) from base R.

Finally we filtered the data for the top 20 countries, plus the United States.

Notice also in this code that a single `=` is used to change or create values, while `==` is used to test whether a value is equal to something.

This code produces exactly the same result, Make sure you understand why:

```R
long_life <- nations %>%
  filter(year == 2016 & !is.na(life_expect)) %>%
  select(country, life_expect, income, region) %>%
  mutate(rank_le = rank(desc(life_expect))) %>%
  arrange(rank_le) %>%
  filter(rank_le <= 20 | country == "United States")
```

##### Now let's find out where Russia ranks, too
```r
# find the 20 countries with the longest life expectancies,
# plus the United States and Russia with their ranks
long_life <- longevity %>%
  mutate(rank_le = rank(desc(life_expect))) %>%
  arrange(rank_le) %>%
  filter(rank_le <= 20 | grepl("United States|Russia", country))
```

This should be the result:

![](img/class7_10.jpg)

This code demonstrates some simple pattern matching on text, using the function `grepl("pattern_a|pattern_b", x)`, which searches variable `x` for values containing any of a list of text values. This is useful for fuzzy text matching. Notice how searching for `Russia` returns `Russian Federation`, which is the country's full name. (`!grepl` will return text strings that *don't* contain the specified pattern.)


**==Note:==** When combining `&` and `|` in more complex filters, use parentheses to determine which parts of the evaluation should be carried out first.


#### Some practice with filtering and sorting

- Find the countries with a life expectancy of between 50 and 60 years in 1990, arranged in descending order of life expectancy.

- Find upper and lower middle income countries with a life expectancy of between 60 and 70 in 1990. Sort in descending order of life expectancy.

- Find countries that in 1990 had a GDP per capita of more than $50,000 dollars and a life expectancy of 70 years or more that were not in Europe or North America. Sort them in ascending order of life expectancy.

#### Write data to a CSV file

**readr** can write data to CSV and other text files. This code will save the result above to a CSV file in your working directory:

```r
# write data to a csv file
write_csv(long_life, "long_life.csv", na="")
```
Although we have no null values here, including `na=""` is good practice, because it ensures that any empty cells in the data frame are saved as blanks, not `NA`.

#### Group and summarize data

##### Summarize the longevity data by year, finding the country-level maximum, minimum, and range.

```r
# summarize the data by year, finding the maximum and minimum country-level life expectancies, and then calculate the range of values
longevity_summary <- nations %>%
  filter(!is.na(life_expect)) %>%
  group_by(year) %>%
  summarize(countries = n(),
            max_life_expect = max(life_expect),
            min_life_expect = min(life_expect)) %>%
  mutate(range_life_expect = max_life_expect - min_life_expect) %>%
  arrange(desc(year))
```

This should be the result:

![](img/class7_11.jpg)

This code introduces the functions `group_by` and `summarize`. The entire `summarize` function could be written on one line, but I have started a new line after each summary statistic for clarity.

In this example, we calculated the number of countries for which we have data in each year, then the maximum and minimum country-level life expectancies. Having done that, we used the `mutate` function to calculate the range of values by subtracting the minimum from the maximum.

##### Calculate total GDP by region and year

```r
# total GDP, in trillions of dollars, by region, over time
gdp_regions <- nations %>%
  mutate(gdp = gdp_percap * population,
         gdp_tn = gdp/1000000000000) %>%
  group_by(region, year) %>%
  summarize(total_gdp_tn = sum(gdp_tn, na.rm = TRUE))
```
Here are the first few rows in the data that is returned:

![](img/class7_12.jpg)

We could also write `10^12` (10 raised to the power of 12) instead of `1000000000000` in this example.

Notice that variables created within a `mutate` function can be immediately used within the same function.

Here the `group_by` function groups on two variables, `region` and `year`.

Notice that the `sum` function used to add up the GDP values across countries within each region and year includes the argument `na.rm = TRUE`, to remove the `NA` values before running the calculation. See what happens if you don't include this. Previously this wasn't necessary because I had started by filtering out the `NA`s.

**==Note:==** Get into the habit of including `na.rm = TRUE` in your summary functions, to avoid problems caused by null values!

#### Some practice with grouping and summarizing (and filtering and sorting)

- Calculate the total GDP by income group and year. Sort the results in descending order of years and, within year, in descending order of GDP.

- Calculate the total GDP for the East Asia & Pacific region, by income group and year.

#### Join data from two data frames

There are also a number of **join** functions in **dplyr** to combine data from two data frames. Here are the most useful:

- `inner_join()` returns values from both tables only where there is a match.
- `left_join()` returns all the values from the first-mentioned table, plus those from the second table that match.
- `semi_join()` filters the first-mentioned table to include only values that have matches in the second table.
- `anti_join()` filters the first-mentioned table to include only values that have no matches in the second table.

[Here is a useful reference](http://stat545-ubc.github.io/bit001_dplyr-cheatsheet.html) for managing joins with **dplyr**.

This code will join `nations2` to `nations`

```r
# join nations to nations2
nations <- inner_join(nations, nations2)
```

In this case, `left_join` and `right_join` would also produce the same result, as both data frames have records for every country and year.

By default, **dplyr** looks for variables with matching names, here `iso3c` and `year`, and joins on those. But you can also specify exactly how a join should be made, like this:

```r
nations <- inner_join(nations, nations2, by = c("iso3c" = "iso3c", "year" = "year"))
```
##### Calculate total carbon dioxide emissions by region and year

In the joined data frame, we can now calculate the total carbon dioxide emissions for each country and each year, and then add up the totals by region over the years:

```r
# total carbon dioxide, in gigatonnes, by region, over time
co2_regions <- nations %>%
  filter(year <= 2014) %>%
  mutate(co2 = co2_percap * population / 10^9) %>%
  group_by(region, year) %>%
  summarize(total_co2 = sum(co2, na.rm = TRUE))
```
Here are the first few rows in the data that is returned:

![](img/class7_13.jpg)

The carbon dioxide emissions data ends in 2014, so first we filtered the data to remove the subsequent two years, before creating a new variable for total emissions from the per capita value, dividing by a billion, or 10 to the power of nine, to get the result in billions of tonnes (gigatonnes). Finally we grouped and summarized by year and region.

### Load California kindergarten immunization data

Now we'll work with the California immunization data.

```r
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
```

We need to append the data for 2015 to the older data. So this code specifies the data type for each variable, to be sure that there won't be any mismatches in data type that would cause an error in the next step.

#### Append the 2015 data to the older data using `bind_rows`

```r
# append the 2015 data to the older data
immun <- bind_rows(immun, immun_2015)
```

This code introduces the `bind_rows` fucntion, which appends one data frame to another, based on matching column names and data types. (If a column exists in one data frame but not in the other, `NA`s will be added where necessary.)

#### Calculate the percentage of children with incomplete immunizations, for the entire state, and by county

The data contains the number of children enrolled in each kindergarten across the state, and the number who had the complete recommended immunizations at the start of the year.

From this, we can calculate the percentage of children who did not have the complete schedule of immunizations. The following code runs these calculations for each year, first for the entire state, summing across all kindergartens grouped by year, and then for each of California's 58 counties, by changing the `group_by` function.

```r
# percentage incomplete, entire state, by year
immun_year <- immun %>%
  group_by(start_year) %>%
  summarize(enrolled = sum(enrollment, na.rm=TRUE),
            completed = sum(complete, na.rm=TRUE)) %>%
  mutate(pc_incomplete = round(((enrolled-completed)/enrolled*100),2))
```
This should be the result:

![](img/class7_14.jpg)

Notice how the `round(x,n)` function is used to round values for `x`, here the percentage incomplete calculation, to `n` decimal places, here 2. Using negative numbers for `n` will round to tens (-1), hundreds (-2), and so on.

```r
# percentage incomplete, by county, by year
immun_counties_year <- immun %>%
  group_by(county,start_year) %>%
  summarize(enrolled = sum(enrollment, na.rm = TRUE),
            completed = sum(complete, na.rm = TRUE)) %>%
  mutate(pc_incomplete = round(((enrolled-completed)/enrolled*100),2))
```
Here are the first few rows of the data that should be returned:

![](img/class7_15.jpg)

Now we can identify the five largest counties with the largest enrollment over the years, and use a join to filter the data by counties for just these five:

```r
# identify five counties with the largest enrollment over all years
top5 <- immun %>%
  group_by(county) %>%
  summarize(enrolled = sum(enrollment, na.rm = TRUE)) %>%
  arrange(desc(enrolled)) %>%
  head(5) %>%
  select(county)

# proportion incomplete, top 5 counties by enrollment, by year
immun_top5_year <- semi_join(immun_counties_year, top5)
```
Notice the use of `semi_join` to filter the data for just the five counties with the largest kindergarten enrollment.

### Close RStudio

Before you exit RStudio, save and close you script, and close any data files you have open in `View`. If you don't RStudio will try to open then next time you launch it.

### Keep R and RStudio up to date

From time to time, check [here](https://www.r-project.org/) to see if you have the latest version of R. If you don't, close RStudio and download the latest version of R and install. RStudio will automatically find this version when you open it once more.

When R moves to a major new version, for example from `3.4` to `3.5`, it creates a new folder for your packages for that version, which will not include the packages you installed previously. The code below will reinstall your packages for the new version. (The number in the file path should reflect the *old* version from which you are upgrading.)

```R
# update installed packages for new R version
package_df <- as.data.frame(installed.packages("/Library/Frameworks/R.framework/Versions/3.4/Resources/library"))

package_list <- as.character(package_df$Package)

install.packages(package_list)
```

You do not need to do this when updating to a new minor version, for example from `3.5.1` to `3.5.2`.

Finally, from time to time check you have the latest verion of RStudio by selecting `Help>Check for Updates` from the top menu. If you do not have the latest version you will be given an option to quit and download the last version.
### Further reading

**[Introduction to dplyr](https://cran.r-project.org/web/packages/dplyr/vignettes/dplyr.html)**

**[RStudio Data Wrangling Cheet Sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf)**
Also introduces the [tidyr](https://blog.rstudio.org/2014/07/22/introducing-tidyr/) package, which can manage wide-to-long transformations, and text-to-columns splits, among other data manipulations.

**[Stack Overflow](http://stackoverflow.com/)**
For any work involving code, this question-and-answer site is a great resource for when you get stuck, to see how others have solved similar problems. Search the site, or [browse R questions](http://stackoverflow.com/questions/tagged/r)

