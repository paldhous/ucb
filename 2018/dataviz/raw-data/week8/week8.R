# load required packages
library(ggplot2)
library(readr)
library(dplyr)

# load disease and democracy data
disease_democ <- read_csv("disease_democ.csv")

# map values in data to X and Y axes
ggplot(disease_democ, aes(x = infect_rate, y = democ_score))

# customize axis labels
ggplot(disease_democ, aes(x = infect_rate, y = democ_score)) +
  xlab("Infectious disease prevalence score") +
  ylab("Democratization score")

# Change the theme
ggplot(disease_democ, aes(x = infect_rate, y = democ_score)) +
  xlab("Infectious disease prevalence score") + 
  ylab("Democratization score") +
  theme_minimal(base_size = 14, base_family = "Georgia")

# save chart template
disease_democ_chart <- ggplot(disease_democ, aes(x = infect_rate, y = democ_score)) +
  xlab("Infectious disease prevalence score") + 
  ylab("Democratization score") +
  theme_minimal(base_size = 14, base_family = "Georgia")

# add a layer with points
disease_democ_chart +
  geom_point()

# add a trend line
disease_democ_chart +
  geom_point() +
  geom_smooth()

names(postscriptFonts())

library(extrafont)
font_import()
loadfonts()


# customize the two geom layers
disease_democ_chart +
  geom_point(size = 3, alpha = 0.5) +
  geom_smooth(method = lm, se=FALSE, color = "red")

# customize again, coloring the points by income group
disease_democ_chart + 
  geom_point(size = 3, alpha = 0.5, aes(color = income_group)) +
  geom_smooth(method = lm, se = FALSE, color = "black", linetype = "dotdash", size = 0.3)

# color the entire chart by income group
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
  scale_x_continuous(limits=c(0,60)) +
  scale_y_continuous(limits=c(0,100)) +
  scale_color_brewer(palette = "Set1",
                     name="Income group", 
                     breaks=c("High income: OECD","High income: non-OECD","Upper middle income","Lower middle income","Low income"))

# save final disease and democracy chart
final_disease_democ_chart <- disease_democ_chart +
  geom_point(size = 3, alpha = 0.5, aes(color = income_group)) +
  geom_smooth(method = lm, se = FALSE, color = "black", linetype = "dotdash", size = 0.3) +
  scale_x_continuous(limits=c(0,60)) +
  scale_y_continuous(limits=c(0,100)) +
  scale_color_brewer(palette = "Set1",
                     name="Income group", 
                     breaks=c("High income: OECD","High income: non-OECD","Upper middle income","Lower middle income","Low income"))  
  
# load data
food_stamps <- read_csv("food_stamps.csv")

write.csv(food_stamps,"food_stamps.csv",na="",row.names = F)

# save basic chart template
food_stamps_chart <- ggplot(food_stamps, aes(x = year, y = participants)) +
  xlab("Year") +
  ylab("Participants (millions)") +
  theme_minimal(base_size = 14, base_family = "Georgia")

# line chart
food_stamps_chart +  
  geom_line()

# customize the line, add a title
food_stamps_chart +
  geom_line(size = 1.5, color = "red") +
  ggtitle("Line chart")

# Add a second layer to make a dot-and-line chart
food_stamps_chart +
  geom_line() +
  geom_point() +
  ggtitle("Dot-and-line chart")

# Make a column chart
food_stamps_chart +
  geom_bar(stat = "identity", color = "white") +
  ggtitle("Column chart") 

# set color and fill
food_stamps_chart +
  geom_bar(stat = "identity", 
           color = "#888888", 
           fill = "#CCCCCC", 
           alpha = 0.5) +
  ggtitle("Column chart")

# bar chart
food_stamps_chart +
  geom_bar(stat = "identity", 
           color = "#888888", 
           fill = "#CCCCCC", 
           alpha = 0.5) +
  ggtitle("Bar chart") + 
  coord_flip()


# fill the columns according to values for the cost of the program
food_stamps_chart +
  geom_bar(stat = "identity", 
           color= "white", 
           aes(fill = costs))

# use a colorbrewer sequential palette
food_stamps_chart +
  geom_bar(stat = "identity", 
           color = "#888888", 
           aes(fill = costs)) +
  scale_fill_distiller(name = "Cost\n($ billion)", 
                       palette = "Reds", 
                       direction = 1)


# change position of legend
food_stamps_chart +
  geom_bar(stat = "identity", 
           color = "#888888", 
           aes(fill = costs)) +
  scale_fill_distiller(name = "Cost\n($ billion)", 
                       palette = "Reds", 
                       direction = 1) +
  theme(legend.position=c(0.15,0.8))

# load required package
library(scales)
library(dplyr)

# load data
immun <- read_csv("kindergarten.csv")

# write.csv(immun, "kindergarten.csv", na="", row.names=F)


# create new column with numbers of children with incomplete immunizations
immun <- immun %>%
  mutate(incomplete = enrollment - complete)
  
# percentage incomplete, entire state, by year
immun_year <- immun %>%
  group_by(start_year) %>%
  summarize(enrolled = sum(enrollment, na.rm=TRUE),
            completed = sum(complete, na.rm=TRUE)) %>%
  mutate(pc_incomplete = round(((enrolled-completed)/enrolled*100),2))

# percentage incomplete, by county, by year
immun_counties_year <- immun %>%
  group_by(county,start_year) %>%
  summarize(enrolled = sum(enrollment, na.rm = TRUE),
            completed = sum(complete, na.rm = TRUE)) %>%
  mutate(pc_incomplete = round(((enrolled-completed)/enrolled*100),2))

# identify the five counties with the largest enrollment over all years
top5 <- immun %>%
  group_by(county) %>%
  summarize(enrollment = sum(enrollment, na.rm = TRUE)) %>%
  arrange(desc(enrollment)) %>%
  head(5) %>%
  select(county)

# pc incomplete, top 5 counties for enrollment, by year
immun_top5_year <- semi_join(immun_counties_year, top5)


# dot and line chart, top5 counties, by year
ggplot(immun_top5_year, aes(x = start_year, y = pc_incomplete, color = county)) + 
  scale_color_brewer(palette = "Set1", name = "") +
  geom_line(size=1) +
  geom_point(size=3) +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  scale_y_continuous(limits = c(0,15)) +
  scale_x_continuous(breaks = c(2002,2004,2006,2008,2010,2012,2014)) +
  xlab("") +
  ylab("% incomplete") +
  theme(legend.position = "bottom") +
  ggtitle("Immunization in California kindergartens\n(five largest counties)")

# heat map, all counties, by year
ggplot(immun_counties_year, aes(x = start_year, y = county)) +
  geom_tile(aes(fill = pc_incomplete), colour = "white") +
  scale_fill_gradient(low = "white",
                      high = "red",
                      name="") +
  scale_x_continuous(breaks = c(2002,2004,2006,2008,2010,2012,2014)) +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  xlab("") +
  ylab("County") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        legend.position="bottom",
        legend.key.height = unit(0.4, "cm")) +
  ggtitle("Immunization in California kindergartens, by county")

# bar chart by year, entire state
ggplot(immun_year, aes(x=start_year, y=pc_incomplete)) +
  geom_bar(stat="identity", fill="red", alpha=0.7) +
  theme_minimal(base_size = 14, base_family = "Georgia") +
  scale_x_continuous(breaks = c(2002,2004,2006,2008,2010,2012,2014)) +
  xlab("") +
  ylab("% incomplete") +
  ggtitle("Immunization in California kindergartens",subtitle="Percent of children without complete shots, entire state") +
  theme(panel.grid.major.x = element_blank(),
      panel.grid.minor.x = element_blank())


# load data
nations <- read_csv("nations.csv")

# filter for 2015 data only
nations2016 <- nations %>%
  filter(year == 2016)

# make bubble chart
ggplot(nations2016, aes(x = gdp_percap, y = life_expect)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  geom_point(aes(size = population, color = region), alpha = 0.7) +
  scale_size_area(guide = FALSE, max_size = 15) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(formula = y ~ log10(x), se = FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2") +
  theme(legend.position=c(0.8,0.4))





# assignment

nations <- nations %>%
  mutate(gdp_tn = gdp_percap*population/1000000000000)

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

install.packages("esquisse")


