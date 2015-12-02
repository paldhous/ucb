# Load required packages
library(dplyr)
library(rCharts)
library(WDI)

# get data for nations' per capita CO2 emissions in metric tonnes 
# from http://data.worldbank.org/indicator/EN.ATM.CO2E.KT
# 2000 onwards

# import data for regions "Z4", "Z7", "ZJ", "ZQ", "XU", "8S", "ZG"
co2 <- WDI(country = "all", indicator = "EN.ATM.CO2E.KT", start = 2000, end = 2011) %>%
  filter(iso2c == "XU" | iso2c == "Z7" | iso2c == "ZQ" | iso2c == "Z4" | iso2c == "ZJ" | iso2c == "ZQ" | iso2c == "8S") %>%
  rename(co2 = EN.ATM.CO2E.KT) %>%
  mutate(co2 = round(co2/1000000, digits=2))

# tidy up the text labels
co2$country <- gsub("all income levels", "", co2$country)
co2$country <- gsub("\\(", "", co2$country)
co2$country <- gsub("\\)", "", co2$country)

# draw chart
co2_stacked <- nPlot(co2 ~ year, 
                       group = "country", 
                       data = co2, 
                       type = "stackedAreaChart"
                    )

# plot chart
co2_stacked

# save the chart as web page
co2_stacked$save("co2.html", cdn = FALSE)









