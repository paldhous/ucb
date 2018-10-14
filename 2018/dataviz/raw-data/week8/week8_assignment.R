# load required packages
library(ggplot2)
library(dplyr)
library(readr)

# load and process data
nations <- read_csv("nations.csv")

nations <- nations %>%
  mutate(gdp_tn = gdp_percap*population/10^12)

# chart1
top_nations <- nations %>%
  filter(grepl("CHN|USA|JPN|DEU",iso3c))

ggplot(top_nations, aes(x=year,y=gdp_tn,color=country)) +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  xlab("") +
  ylab("GDP ($ trillion)") +
  geom_line() +
  geom_point() +
  scale_color_brewer(palette = "Set1", name="") +
  theme(legend.position = "bottom")

# chart2
regions <- nations %>%
  group_by(region, year) %>%
  summarize(gdp_tn = sum(gdp_tn, na.rm = TRUE))

ggplot(regions, aes(x=year,y=gdp_tn,fill=region)) +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  xlab("") +
  ylab("GDP ($ trillion)") +
  geom_area(color="white") +
  scale_fill_brewer(palette = "Set2", name="")


