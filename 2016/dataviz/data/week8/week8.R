# load required packages
library(dplyr)
library(readr)
library(ggplot2)
library(scales)

# load data
nations <- read_csv("nations.csv")

nations <- nations %>%
  mutate(gdp_tn = gdp_percap*population/1000000000000) 

top_economies <- nations %>%
  filter(country == "United States" | country == "China" | country == "Russian Federation" | country == "Japan" | country == "Germany")
  
ggplot(top_economies, aes(x=year, y=gdp_tn, color=country)) +
  xlab("") +
  ylab("GDP ($ trillion)") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  scale_color_brewer(name = "", palette = "Set2") +
  geom_line() +
  geom_point() +
  theme(legend.position = "top")
  
nations2014 <- nations %>%
  filter(year == 2014)

ggplot(nations2014, aes(x=gdp_percap, y=life_expect)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  geom_point(aes(size=population, color=region), alpha = 0.7) +
  scale_size_area(guide=FALSE) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(formula = y ~ log10(x), se=FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2")

regions_gdp <- nations %>%
  group_by(region, year) %>%
  summarize(sum_gdp = sum(gdp_tn, na.rm=TRUE))
  
ggplot(regions_gdp, aes(x=year, y=sum_gdp, color=region)) +
  xlab("") +
  ylab("GDP ($ trillion)") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  scale_color_brewer(name = "", palette = "Set2") +
  geom_line() +
  geom_point() +
  theme(legend.position = "top")



