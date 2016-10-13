# load required packages
library(ggplot2)
library(readr)
library(dplyr)

# load disease and democracy data
disease_democ <- read_csv("disease_democ.csv")

ggplot(disease_democ, aes(x = infect_rate, y = democ_score))

# customize axis labels
ggplot(disease_democ, aes(x = infect_rate, y = democ_score)) +
  xlab("Infectious disease prevalence score") +
  ylab("Democratization score")

ggplot(disease_democ, aes(x = infect_rate, y = democ_score)) +
  xlab("Infectious disease prevalence score") + 
  ylab("Democratization score") +
  theme_minimal(base_size = 14, base_family = "Georgia")

disease_democ_chart <- ggplot(disease_democ, aes(x = infect_rate, y = democ_score)) +
  xlab("Infectious disease prevalence score") + 
  ylab("Democratization score") +
  theme_minimal(base_size = 14, base_family = "Georgia")

plot(disease_democ_chart)


# add a layer with points
disease_democ_chart +
  geom_point()


# add a trend line
disease_democ_chart +
  geom_point() +
  geom_smooth()

# customize the two geom layers
disease_democ_chart +
  geom_point(size = 3, alpha = 0.5) +
  geom_smooth(method = lm, se=FALSE, color = "red")

# customize the two geom layers
disease_democ_chart +
  geom_point(size = 3, alpha = 0.5) +
  geom_smooth(method = lm, se=FALSE, color = "#FF0000")


disease_democ_chart + 
  geom_point(size = 3, alpha = 0.5, aes(color = income_group)) +
  geom_smooth(method = lm, se  =FALSE, color = "black", linetype = "dotdash", size = 0.3)

ggplot(disease_democ, aes(x = infect_rate, y = democ_score, color=income_group)) +
  xlab("Infectious disease prevalence score") + 
  ylab("Democratization score") +
  theme_minimal(base_size = 14, base_family = "Georgia") + 
  geom_point(size = 3, alpha = 0.5) +
  geom_smooth(method=lm, se=FALSE, linetype= "dotdash", size = 0.3)

# set the axis ranges, change color palette
disease_democ_chart + 
  geom_point(size = 3, alpha = 0.5, aes(color = income_group)) +
  geom_smooth(method = lm, se = FALSE, color = "black", linetype = "dotdash", size = 0.3) + 
  scale_x_continuous(limits=c(0,70)) + 
  scale_y_continuous(limits=c(0,100)) +
  scale_color_brewer(name="Income group", palette = "Set1") 

# load data
food_stamps <- read_csv("food_stamps.csv")

# save basic chart template
food_stamps_chart <- ggplot(food_stamps, aes(x = year, y = participants)) + 
  xlab("Year") +
  ylab("Participants (millions)") +
  theme_minimal(base_size = 14, base_family = "Georgia")

#### Make a line chart

# line chart
food_stamps_chart +  
  geom_line()

food_stamps_chart +
  geom_line(size = 1.5, color = "red") +
  ggtitle("Line chart")

food_stamps_chart +
  geom_line() +
  geom_point() +
  ggtitle("Dot-and-line chart")

food_stamps_chart +
  geom_bar(stat = "identity") +
  ggtitle("Bar chart") +
  theme(panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  coord_flip

food_stamps_chart +
  geom_bar(stat = "identity", color = "#888888", fill = "#CCCCCC", alpha = 0.5) +
  ggtitle("Column chart")

food_stamps_chart +
  geom_bar(stat = "identity", color= "white", aes(fill = costs))

food_stamps_chart +
  geom_bar(stat = "identity", color = "#888888", aes(fill = costs)) +
  scale_fill_distiller(name = "Cost\n($ billion)", palette = "Reds", direction = 1)

food_stamps_chart +
  geom_bar(stat="identity", color = "#888888", aes(fill=costs)) +
  scale_fill_distiller(name = "Cost\n($ billion)", palette = "Reds", direction = 1) +
  theme(legend.position=c(0.15,0.8))

library(scales)

# load data
immun <- read_csv("kindergarten.csv")

#### Calculate proportion of children with incomplete immunizations for the entire state and by county

# proportion incomplete, entire state, by year
immun_year <- immun %>%
  group_by(start_year) %>%
  summarize(enrolled=sum(enrollment, na.rm=TRUE),completed=sum(complete, na.rm=TRUE)) %>%
  mutate(incomplete=round(((enrolled-completed)/enrolled),4))

# proportion incomplete, by county, by year
immun_counties_year <- immun %>%
  group_by(county,start_year) %>%
  summarize(enrolled = sum(enrollment, na.rm = TRUE),completed=sum(complete, na.rm = TRUE)) %>%
  mutate(incomplete = round(((enrolled-completed)/enrolled),4))

# identify five counties with the largest enrollment over all years
top5 <- immun %>%
  group_by(county) %>%
  summarize(enrolled = sum(enrollment, na.rm = TRUE)) %>%
  arrange(desc(enrolled)) %>%
  head(5) %>%
  select(county)

# proportion incomplete, top 5 counties by enrollment, by year
immun_top5_year <- semi_join(immun_counties_year, top5)


ggplot(immun_year, aes(x = start_year, y = incomplete)) + 
  geom_bar(stat = "identity", fill = "red", alpha = 0.7) +
  theme_minimal(base_size = 12) +
  scale_y_continuous(labels = percent) +
  scale_x_continuous(breaks = c(2002,2004,2006,2008,2010,2012,2014)) +
  xlab("") +
  ylab("Incomplete") +
  ggtitle("Immunization in California kindergartens, entire state") + 
  theme(panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank())


ggplot(immun_top5_year, aes(x = start_year, y = incomplete, color = county)) + 
  scale_color_brewer(palette = "Set1", name = "") +
  geom_line(size=1) +
  geom_point(size=3) +
  theme_minimal(base_size = 12) +
  scale_y_continuous(labels = percent, limits = c(0,0.15)) +
  scale_x_continuous(breaks = c(2002,2004,2006,2008,2010,2012,2014)) +
  xlab("") +
  ylab("Incomplete") +
  theme(legend.position = "bottom") +
  ggtitle("Immunization in California kindergartens\n(five largest counties)")

ggplot(immun_counties_year, aes(x = start_year, y = county)) +
  geom_tile(aes(fill = incomplete), colour = "white") +
  scale_fill_gradient(low = "white",
                      high = "red", 
                      name="",
                      labels = percent) +
  scale_x_continuous(breaks = c(2002,2004,2006,2008,2010,2012,2014)) +
  theme_minimal(base_size = 12) +
  xlab("") +
  ylab("County") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position="bottom",
        legend.key.height = unit(0.4, "cm")) +
  ggtitle("Immunization in California kindergartens, by county")

nations <- read_csv("nations.csv")

# filter for 2014 data only
nations2014 <- nations %>%
  filter(year == 2014)

# make bubble chart
ggplot(nations2014, aes(x = gdp_percap, y = life_expect)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  geom_point(aes(size = population, color = region), alpha = 0.7) +
  scale_size_area(guide = FALSE, max_size = 15) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(formula = y ~ log10(x), se = FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2") +
  theme(legend.position=c(0.8,0.4))

# load data
nations <- read_csv("nations.csv")

write_csv(immun, "nations.csv", na="")

str(immun)

immun <- immun %>%
  mutate(start_year=as.integer(start_year))


nations <- nations %>%
  mutate(gdp_tn = gdp_percap*population/1000000000000)

top_economies <- nations %>%
  filter(country == "United States" | country == "China" | country == "Japan" | country == "Germany")

ggplot(top_economies, aes(x = year, y = gdp_tn, color = country)) +
  xlab("") +
  ylab("GDP ($ trillion)") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  scale_color_brewer(name = "", palette = "Set1") +
  scale_x_continuous(breaks = c(1990,1995,2000,2005,2010)) +
  geom_line() +
  geom_point() +
  theme(legend.position = "bottom") +
  ggtitle("China's rise to become the largest economy")

region_gdp_2014 <- nations %>%
  filter(year == 2014) %>%
  group_by(region) %>%
  summarize(gdp_total=sum(gdp_tn, na.rm=TRUE))

ggplot(region_gdp_2014, aes(x=reorder(region, gdp_total), y=gdp_total, fill=region)) +
  geom_bar(stat="identity") +
  xlab("") +
  ylab("GDP ($ trillion)") +
  ggtitle("GDP in 2014, by region") +
  scale_fill_brewer(palette="Set2", guide=FALSE) +
  theme_minimal() +
  theme(panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank()) +
  coord_flip() 


# Make these two charts

top_economies <- nations %>%
  filter(country == "United States" | country == "China" | country == "Japan" | country == "Germany")

ggplot(top_economies, aes(x = year, y = gdp_tn, color = country)) +
  xlab("") +
  ylab("GDP ($ trillion)") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  scale_color_brewer(name = "", palette = "Set1") +
  scale_x_continuous(breaks = c(1990,1995,2000,2005,2010)) +
  geom_line() +
  geom_point() +
  theme(legend.position = "bottom") +
  ggtitle("China's rise to become the largest economy")


region_gdp <- nations %>%
  group_by(region, year) %>%
  summarize(gdp_total=sum(gdp_tn, na.rm=TRUE))

ggplot(region_gdp, aes(x=year, y=gdp_total, fill=region)) +
  xlab("") +
  ylab("GDP ($ trillion)") +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  scale_fill_brewer(name = "", palette = "Set2") +
  scale_x_continuous(breaks = c(1990,1995,2000,2005,2010)) +
  # geom_area() +
  geom_area(color = "white", size = 0.2) +
  ggtitle("GDP by World Bank region")





