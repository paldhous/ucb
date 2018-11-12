# load required packages
library(plotly)
library(readr)
library(dplyr)

# load data
food_stamps <- read_csv("food_stamps2.csv")

# dot-and-line chart
food_stamps_chart <- ggplot(food_stamps, aes(x = year, y = participants)) +
  xlab("Year") +
  ylab("Participants (millions)") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  geom_point() +
  geom_line()

plot(food_stamps_chart)

# make interactive version
food_stamps_interactive <- ggplotly(food_stamps_chart)

print(food_stamps_interactive)

# remove plotly controls
food_stamps_interactive <- ggplotly(food_stamps_chart) %>% 
  config(displayModeBar = FALSE)

print(food_stamps_interactive)

# customize the tooltips
food_stamps_chart <- ggplot(food_stamps, aes(x = year, 
                                             y = participants,
                                             text = paste0("<b>Year: </b>", year,"<br>",
                                                           "<b>Participants: </b>", participants," million<br>",
                                                           "<b>Costs: </b> $", costs, " billion"),
                                             group = 1)) +
  xlab("Year") +
  ylab("Participants (millions)") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  geom_point() +
  geom_line()

food_stamps_interactive <- ggplotly(food_stamps_chart, tooltip = "text") %>% 
  config(displayModeBar = FALSE)

print(food_stamps_interactive)

# load data
disease_democ <- read_csv("disease_democ.csv")

# make static chart
disease_democ_chart <- ggplot(disease_democ, aes(x = infect_rate, 
                                                 y = democ_score,
                                                 text = paste0("<b>Country: </b>", country,"<br>",
                                                               "<b>Infectious disease prevalence: </b>", infect_rate,"<br>",
                                                               "<b>Democratization: </b>", democ_score),
                                                 group = 1)) +
  xlab("Infectious disease prevalence score") + 
  ylab("Democratization score") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  geom_point() +
  geom_smooth(method = lm, se = FALSE)

plot(disease_democ_chart)


# make interactive version
disease_democ_interactive <- ggplotly(disease_democ_chart, tooltip = "text") %>%
  config(displayModeBar = FALSE)

print(disease_democ_interactive)


# make static chart
disease_democ <- disease_democ %>%
  mutate(income_group = factor(income_group, levels = c("High income: non-OECD",
                                               "High income: OECD",
                                               "Upper middle income",
                                               "Lower middle income",
                                               "Low income"))) %>%
  arrange(income_group)

glimpse(disease_democ)

disease_democ_chart <- ggplot(disease_democ, aes(x = infect_rate, 
                                                 y = democ_score,
                                                 text = paste0("<b>Country: </b>", country,"<br>",
                                                               "<b>Infectious disease prevalence: </b>", infect_rate,"<br>",
                                                               "<b>Democratization: </b>", democ_score),
                                                 group = 1)) +
  xlab("Infectious disease prevalence score") + 
  ylab("Democratization score") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  geom_smooth(method = lm, se = FALSE, color = "black", linetype = "dotdash", size = 0.3) +
  geom_point(aes(color=income_group), size = 3, alpha = 0.5) +
  scale_color_brewer(palette = "Set1",
                     name="Income group",
                     breaks=c("High income: OECD","High income: non-OECD","Upper middle income","Lower middle income","Low income"))

plot(disease_democ_chart)

# make interactive version
disease_democ_interactive <- ggplotly(disease_democ_chart, tooltip="text") %>% 
  config(displayModeBar = FALSE)

print(disease_democ_interactive)

## CA immunization

# load data
immun <- read_csv("kindergarten.csv")

# calculate percentage incomplete, by county, by year
immun_counties_year <- immun %>%
  group_by(county,start_year) %>%
  summarize(enrolled = sum(enrollment, na.rm = TRUE),
            completed = sum(complete, na.rm = TRUE)) %>%
  mutate(pc_incomplete = round((enrolled-completed)/enrolled*100,2))

# heat map, all counties, by year
immun_counties_year_chart <- ggplot(immun_counties_year, aes(x = start_year,
                                                             y = county,
                                                             text = paste0("<b>Year: </b>", start_year,"<br>",
                                                                           "<b>County: </b>", county,"<br>",
                                                                           "<b>% incomplete: </b>", pc_incomplete,"<br>"),
                                                             group = 1)) +
  geom_tile(aes(fill = pc_incomplete), color = "white") +
  scale_fill_gradient(low = "white",
                      high = "red",
                      name="% incomplete") +
  scale_x_continuous(breaks = c(2002,2004,2006,2008,2010,2012,2014)) +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  xlab("") +
  ylab("") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position="bottom",
        legend.key.height = unit(0.4, "cm")) +
  ggtitle("Immunization in California kindergartens, by county")

plot(immun_counties_year_chart)

immun_counties_year_chart_interactive <- ggplotly(immun_counties_year_chart, tooltip = "text") %>% 
  config(displayModeBar = FALSE)

print(immun_counties_year_chart_interactive)

########
# seismic risk and quakes map with leaflet

# load required packages
library(rgdal)
library(leaflet)

# make leaflet map centered on Berkeley
leaflet() %>% 
  setView(lng = -122.2705383, lat = 37.8698807, zoom = 11) %>%
  addTiles()

# make leaflet map centered on Berkeley with Carto tiles
leaflet() %>%
  setView(lng = -122.2705383, lat = 37.8698807, zoom = 11) %>%
  addProviderTiles("CartoDB.Positron")

# load seismic risk shapefile
seismic <- readOGR("seismic", "seismic")

# view summary of seismic_risk data
summary(seismic)

glimpse(seismic@data)

# view summary of seismic_risk data
summary(seismic)


# load quakes data from USGS earthquakes API
quakes <- read_csv("https://earthquake.usgs.gov/fdsnws/event/1/query?starttime=1960-01-01T00:00:00&minmagnitude=6&format=csv&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&orderby=magnitude")

# convert to factor/categorical variable
seismic@data <- seismic@data %>%
  mutate(ValueRange = factor(ValueRange, levels = c("< 1","1 - 2","2 - 5","5 - 10", "10 - 12")))

levels(seismic@data$ValueRange)

# view summary of seismic_risk data
summary(seismic)

# set color palette
pal <- colorFactor("Reds", seismic$ValueRange)

leaflet(data = seismic) %>%
  setView(lng = -98.5795, lat = 39.828175, zoom = 4) %>%
  addProviderTiles("CartoDB.Positron") %>% 
  addPolygons(
    stroke = FALSE,
    fillOpacity = 0.7,
    smoothFactor = 0.1,
    color = ~pal(ValueRange)
  ) %>%
  # add historical earthquakes
  addCircles(
    data = quakes, 
    radius = sqrt(10^quakes$mag)*30, 
    color = "#000000",
    weight = 0.2,
    fillColor ="#ffffff",
    fillOpacity = 0.5,
    popup = paste0("<strong>Magnitude: </strong>", quakes$mag, "</br>",
                   "<strong>Date: </strong>", format(as.Date(quakes$time), "%b %d, %Y"))
  ) %>%
  # add legend
  addLegend(
    "bottomright", pal = pal, values = ~ValueRange,
    title = "annual % risk of damaging quake",
    opacity = 0.7,
    labels = labels
  )