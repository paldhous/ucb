# load required libraries
library(devtools)
library(leaflet)
library(dplyr)
library(rgdal)
library(htmlwidgets)
library(RColorBrewer)
library(ggplot2)
library(dygraphs)
library(xts)
library(WDI)
library(networkD3)
library(jsonlite)
library(rCharts)

setwd("~/Dropbox/ucb/2015/dataviz/raw-data/r-interactive")

install_github("rCharts", "ramnathv")

# import World Bank data

# list of indicators to be imported
indic_list <- c("SP.DYN.LE00.IN", "SH.XPD.PCAP.PP.KD", "SL.UEM.TOTL.ZS")

# import indicators , rename fields, and round numbers
indicators <- WDI(indicator=indic_list, country="all", start=1990, end=2013) %>%
  rename(life_expect=SP.DYN.LE00.IN, health_spend=SH.XPD.PCAP.PP.KD, unemploy_rate=SL.UEM.TOTL.ZS) %>%
  mutate(life_expect=round(life_expect, digits=2),unemploy_rate=round(unemploy_rate, digits=2), health_spend=round(health_spend, digits=0))

# filter for countries/region of interest, and perform custom sort
countries <- filter(indicators, iso2c=="GR"|iso2c=="DE"|iso2c=="EU"|iso2c=="RU")
  
# edit country/region names
countries$country <- gsub("Russian Federation", "Russia", countries$country)
countries$country <- gsub("European Union", "EU", countries$country)

# make life expectancy line chart with NVD3
life_expect_n <- nPlot(life_expect ~ year, 
                          group="country", 
                          data = countries, 
                          type = "lineChart")
life_expect_n$yAxis(axisLabel=("Life expectancy at birth (years)"))
life_expect_n$chart(color = c("#e41a1c", "#377eb8", "#4daf4a", "#984ea3"))

# plot chart
life_expect_n

# save chart as a web page
life_expect_n$save("life_expect_n.html", cdn = FALSE)

# examples
https://github.com/ramnathv/rCharts/blob/master/inst/libraries/nvd3/examples.R

# make life expectancy line chart with HighCharts
life_expect_h <- hPlot(life_expect ~ year, 
                          group = "country", 
                          data = countries, 
                          type = "line")
life_expect_h$yAxis(title = list(text = "Life expectancy at birth (years)"))
life_expect_h$xAxis(title = list(text = ""))
life_expect_h$colors("#e41a1c", "#377eb8", "#4daf4a", "#984ea3")
life_expect_h$plotOptions(line=list(marker=list(enabled=FALSE)))

# plot chart
life_expect_h

# save the chart as web page
life_expect_h$save("life_expect_h.html", cdn = FALSE)

# examples
https://github.com/ramnathv/rCharts/blob/master/inst/libraries/highcharts/examples.R


# import storms data

storms <- read.csv("storms.csv") 

# count storms and hurricanes per year
storms_year <- storms %>%
  filter(year >= 1980) %>%
  group_by(year,name) %>%
  summarize(max_wind = max(max_wind_mph, na.rm = TRUE)) %>%
  mutate(type=ifelse(max_wind >= 74, "Hurricanes", "Storms")) %>%
  ungroup() %>%
  group_by(year, type) %>%
  summarize(count = n())
    
# make column chart with NVD3
storms_n <- nPlot(count ~ year, 
                       group="type", 
                       data = storms_year, 
                       type = "multiBarChart")
storms_n$yAxis(axisLabel=("Number of storms"),
               tickFormat = "#! d3.format(',0f') !#")
storms_n$chart(showControls = FALSE,
               stacked = TRUE)

# plot chart
storms_n

# save the chart as web page
storms_n$save("storms_n.html", cdn = FALSE)

# make storms column chart with HighCharts
storms_h <- hPlot(count ~ year, 
                       group = "type", 
                       data = storms_year, 
                       type = "column")
storms_h$plotOptions(column = list(stacking = "normal"))
storms_h$yAxis(title = list(text = "Number of storms"))
storms_h$xAxis(title = list(text = ""))

# plot chart
storms_h

# save chart
storms_h$save("storms_h.html", cdn = FALSE)

# for Highcharts, replace:

  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/highcharts/js/jquery-1.9.1.min.js' type='text/javascript'></script>
  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/highcharts/js/highcharts.js' type='text/javascript'></script>
  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/highcharts/js/highcharts-more.js' type='text/javascript'></script>
  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/highcharts/js/exporting.js' type='text/javascript'></script>
  
# with
  
  <script src='src/jquery-1.11.3.min.js' type='text/javascript'></script>
  <script src='src/highcharts.js' type='text/javascript'></script>
  <script src='src/highcharts-more.js' type='text/javascript'></script>
  
# for NVD3 replace:
  
  <link rel='stylesheet' href='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/css/nv.d3.css'>
  <link rel='stylesheet' href='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/css/rNVD3.css'>
  
  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/jquery-1.8.2.min.js' type='text/javascript'></script>
  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/d3.v3.min.js' type='text/javascript'></script>
  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/nv.d3.min-new.js' type='text/javascript'></script>
  <script src='/Library/Frameworks/R.framework/Versions/3.2/Resources/library/rCharts/libraries/nvd3/js/fisheye.js' type='text/javascript'></script>
  
# with:
  
  <link rel="stylesheet" href="css/nv.d3.min.css">
  <script src="src/d3.min.js"></script> 
  <script src="src/nv.d3.js"></script>
  <script src="src/jquery-1.11.3.min.js"></script>
  
# also change first width to 100% and comment out second
  
# load Yahoo finance data for Valeant
valeant <- read.csv("http://real-chart.finance.yahoo.com/table.csv?s=VRX") %>%
  mutate(Date=as.Date(Date)) %>%
  select(Date, Close) %>%
  rename(VRX = Close)

# and for GSK
gsk <- read.csv("http://real-chart.finance.yahoo.com/table.csv?s=GSK") %>%
  mutate(Date=as.Date(Date))  %>%
  select(Date, Close) %>%
  rename(GSK = Close)

# combine into a single data frame with separate column for each company 
# and filter for 2010 onwards
valeant_gsk <- left_join(gsk, valeant, by="Date") %>%
  filter(Date >= "2010-01-01")

# convert to extensible time series (xts)
valeant_gsk <- xts(valeant_gsk, order.by = valeant_gsk$Date) 
 
# valeant <- xts(valeant, order.by = valeant$Date)

# dygraph
drug_cos <- dygraph(valeant_gsk) %>%
  dyRangeSelector()

# plot chart
drug_cos

drug_cos <- dygraph(valeant_gsk) %>%
  dyOptions(fillGraph = TRUE, 
            fillAlpha = 0.4) %>%
  dyRangeSelector()

dygraph(valeant) %>%
  dyRangeSelector()

# save the chart
saveWidget(drug_cos, "drug_cos.html", selfcontained = TRUE, libdir = NULL,
           background = "white")


# create leaflet map centered on Berkeley
map <- leaflet() %>% 
  setView(lng = -122.2705383, lat = 37.8698807, zoom = 11)

# add OpenSteetMap basemap
map %>% 
  addTiles() 

# adding basemap from http://leaflet-extras.github.io/leaflet-providers/preview/index.html
map %>% 
  addProviderTiles("CartoDB.Positron")

# load seismic risk shapefile
seismic_risk <- readOGR("seismic_risk_clip", "seismic_risk_clip")

# load quakes data from USGS earthquakes API
quakes <- read.csv("http://earthquake.usgs.gov/fdsnws/event/1/query?starttime=1965-01-01T00:00:00&minmagnitude=6&format=csv&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&orderby=magnitude")

# make leaflet map using seismic risk data
seismic_map <- leaflet(data=seismic_risk)

# make a map with basemap and choropleth seismic risks, using quantiles
seismic_map %>%
  setView(lng = -98.5795, lat = 39.828175, zoom = 4) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addPolygons(
    stroke = FALSE, 
    fillOpacity = 0.7, 
    smoothFactor = 0.2,
    color = ~colorQuantile("Reds", seismic_risk$ACC_VAL, n = 5)(ACC_VAL)
  )

# pal <- colorNumeric(
#   palette = "Reds",
#   domain = seismic_map$ACC_VAL
# )
# 
# summary(seismic_risk)
# 
# seismic_map %>%
#   setView(lng = -98.5795, lat = 39.828175, zoom = 3) %>%
#   addProviderTiles("CartoDB.Positron") %>%
#   addPolygons(
#     stroke = FALSE, fillOpacity = 0.7, smoothFactor = 0.1,
#     color = ~pal(ACC_VAL)
#   )

# look at summary of seismic risk data
summary(seismic_risk)

# set breaks for custom bins
breaks <- c(0,19,39,59,79,200)

# view ColorBrewer palettes
display.brewer.all()

# set palette
binpal <- colorBin("Reds", seismic_map$ACC_VAL, breaks)

# make multi-layered leaflet map
seismic <- seismic_map %>%
  setView(lng = -98.5795, lat = 39.828175, zoom = 4) %>%
  addProviderTiles("CartoDB.Positron", group = "CartoDB") %>% 
  addProviderTiles("Stamen.TonerLite", group = "Toner") %>%
  addPolygons(
    stroke = FALSE, fillOpacity = 0.7, 
    smoothFactor = 0.1,
    color = ~binpal(ACC_VAL)
  ) %>%
  addCircles(
             data=quakes, 
             radius = sqrt(10^quakes$mag)*50, 
             weight = 0.2, 
             color = "#000000", 
             fillColor ="#ffffff",
             opacity = 0.7,
             popup = paste0("<strong>Magnitude: </strong>", quakes$mag, "</br>",
                            "<strong>Date: </strong>", format(as.Date(quakes$time), "%b %d, %Y")),
             group = "Quakes"
  ) %>%
  addLegend(
            "bottomleft", pal = binpal, values = ~ACC_VAL,
            title = "Seismic risk",
            opacity = 0.7
  ) %>%
  addLayersControl(
  baseGroups = c("CartoDB", "Toner"),
  overlayGroups = "Quakes",
  options = layersControlOptions(collapsed = FALSE)
  )

# plot map
seismic

# save the map
saveWidget(seismic, "seismic.html", selfcontained = TRUE, libdir = NULL,
           background = "white")

# d3 network from Senate network data

senate <- fromJSON("senate-113-2014.json")
str(senate)

nodes <- senate$nodes

links <- senate$links %>%
  filter(percent_agree > 0.67)

colors <- JS("d3.scale.ordinal().range(['#ff0000','#0000ff','#d2691e'])")

senate_network <- forceNetwork(
             Links = links, 
             Nodes = nodes, 
             Source = "source",
             Target = "target", 
             NodeID = "id",
             Group = "party", 
             opacity = 1, 
             bounded = TRUE, 
             linkColour = "#cccccc", 
             colourScale = colors
             )

# plot network
senate_network

saveWidget(senate_network, "senate.html", selfcontained = TRUE, libdir = NULL,
           background = "white")


########################################################



# valeant <- read.csv("http://real-chart.finance.yahoo.com/table.csv?s=VRX") %>%
#   mutate(Ticker="VRX", Date=as.Date(Date))
# 
# gsk <- read.csv("http://real-chart.finance.yahoo.com/table.csv?s=GSK") %>%
#   mutate(Ticker="GSK", Date=as.Date(Date))
# 
# valeant_gsk <- rbind(valeant, gsk)
#   
# drugcos_line <- nPlot(Close ~ Date, 
#                           group="Ticker", 
#                           data = valeant_gsk, 
#                           type = "lineWithFocusChart")
# drugcos_line$yAxis(axisLabel=("Daily closing price($)"))
# 
# drugcos_line
# 
# drugcos_line$save("drugcos_line.html", cdn = FALSE)


# # load brain_data.csv
# brain <- read.csv("brain_data.csv")
# 
# # make column chart with NVD3
# brain_column <- nPlot(value ~ species,
#                    data = brain, 
#                    type = "discreteBarChart")
# brain_column$yAxis( tickFormat="#! d3.format(',0f') !#", 
#                  axisLabel=("Brain size (g)"))
# 
# 
# # plot chart
# brain_column
# 
# # save chart
# brain_column$save("brain_column.html", cdn = FALSE)
# 
# # make bar chart with NVD3
# brain_bar <- nPlot(value ~ species,
#                    data = brain, 
#                    type = "multiBarHorizontalChart")
# brain_bar$yAxis( tickFormat="#! d3.format(',0f') !#", 
#                  axisLabel=("Brain size (g)"))
# brain_bar$chart(showControls = FALSE)
# 
# # plot chart
# brain_bar
# 
# # save chart
# brain_bar$save("brain_bar.html", cdn = FALSE)


