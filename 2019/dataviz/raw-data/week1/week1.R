library(ggplot2)
library(dplyr)
library(WDI)
library(readr)
library(scales)
library(rgdal)

# Have updated this for 2018!

############### 
# GDP per capita data

gdp_pc <- WDI(indicator="NY.GDP.PCAP.PP.CD", country="all", start=2017, end=2017, extra=TRUE) %>%
  filter(income != "Aggregates") %>%
  select(2,5,3) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD)

ggplot(gdp_pc, aes(x=gdp_percap, y=..count..)) + 
  geom_histogram(binwidth=2500, fill = "red") + 
  ylab("Number of countries") + 
  xlab("GDP per capita (2015)") + 
  scale_x_continuous(labels = dollar, limits = c(-2500,160000)) +
  theme_minimal(base_size = 14, base_family = "Georgia")

# quantiles
quantile(gdp_pc$gdp_percap, probs = seq(0, 1, 0.2), na.rm = TRUE)

write.csv(gdp_pc, "gdp_pc_2017.csv", na="", row.names = FALSE)

#######################
# baseball salary data

# load the Lahman package
library(Lahman)

# look for most recent data
summary(Salaries$yearID)
summary(Teams$yearID)

# note - use the file from kdmc, which has some manual edits
Teams <- filter(Teams, yearID == 2016)
Salaries <- filter(Salaries, yearID = 2016)
# Fielding <- filter(Fielding, yearID == 2016)

# join to Master and Teams, select fields for export
mlb_salaries_2016 <- inner_join(Salaries, Master, by="playerID") %>%
  left_join(Teams, by=c("teamID"="teamIDBR")) %>%
  mutate(salary_mil=salary/1000000, nameFull=paste(nameFirst, nameLast, sep=" ")) %>%
  rename(teamName=name) %>%
  select(playerID, nameFirst, nameLast, nameFull, teamID, teamName, salary, salary_mil) 

missing <- anti_join(Salaries,mlb_salaries_2016, by="playerID")

# export data 
write.csv(mlb_salaries_2016, "mlb_salaries_2016.csv", row.names = FALSE, na = "")

# here import the kdmc file
mlb_salaries_2016 <- read_csv("mlb_salaries_2016.csv")

# histogram of salaries
ggplot(mlb_salaries_2016, aes(x=salary_mil, y=..count..)) + 
  geom_histogram(binwidth=0.5, fill = "red") + 
  ylab("Number of players") + 
  xlab("Salary ($ millions)") + 
  scale_x_continuous(limits = c(0,35)) +
  theme_minimal(base_size = 14, base_family = "Georgia")

###################### don't need this is make maps with Datawrapper
# GDP per capita map
# world <- readOGR("ne_50m_admin_0_countries_lakes", "ne_50m_admin_0_countries_lakes")
# 
# # join data
# world@data <- left_join(world@data,gdp_pc, by=c("iso_a3"="iso3c"))
# 
# # replace na with -99
# world@data[is.na(world@data)] <- -99                        
#                         
# 
# # write shapefile
# writeOGR(obj=world, dsn="world", layer="world", driver="ESRI Shapefile")

#######################

disease_democ <- read_csv("disease_democ.csv")

ggplot(disease_democ, aes(x=infect_rate, y=democ_score)) + 
  geom_point(size = 3, alpha = 0.5) + 
  geom_smooth(se=FALSE, method = "lm", size = 0.5) +
  ylab("Democratization score") + 
  xlab("Infectious disease prevalence") + 
  scale_x_continuous(limits = c(20,50)) +
  theme_minimal(base_size = 14, base_family = "Georgia")

#######################

# get GDP per capita and life expectancy data

life_wealth_2017 <- WDI(indicator=c("NY.GDP.PCAP.PP.CD","SP.DYN.LE00.IN"), country="all", start=2017, end=2017, extra=TRUE) %>%
  filter(income != "Aggregates") %>%
  select(2,4,5,3) %>%
  rename(gdp_percap=NY.GDP.PCAP.PP.CD,
         life_expect=SP.DYN.LE00.IN)

write.csv(life_wealth_2017, "life_wealth_2017.csv", row.names = FALSE, na = "")


# scatterplot of gdp_pc vs life_expect in 2017
#linear
ggplot(life_wealth_2017, aes(x=gdp_percap, y=life_expect)) + 
  geom_point(size=3, alpha=0.5) + 
  scale_x_continuous(labels = dollar) + 
  stat_smooth(formula=y~log(x), se=FALSE) + 
  xlab("GDP per capita") + 
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 14, base_family = "Georgia")
#logarithmic
ggplot(life_wealth_2017, aes(x=gdp_percap, y=life_expect)) + 
  geom_point(size=3, alpha=0.5) + 
  scale_x_log10(labels = dollar) + 
  geom_smooth(se=FALSE, method="lm") + 
  xlab("GDP per capita") + 
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 14, base_family = "Georgia")

# life expectancy histogram
ggplot(life_wealth_2017, aes(x=life_expect, y=..count..)) + 
  geom_histogram(binwidth=2, fill = "red") + 
  ylab("Number of countries") + 
  xlab("Life expectancy at birth (2017)") + 
  # scale_x_continuous(labels = dollar, limits = c(-2500,160000)) +
  theme_minimal(base_size = 14, base_family = "Georgia")

# gdp per capita histogram
ggplot(life_wealth_2017, aes(x=gdp_percap, y=..count..)) + 
  geom_histogram(binwidth=2500, fill = "red") + 
  ylab("Number of countries") + 
  xlab("GDP per capita (2017)") + 
  scale_x_continuous(labels = dollar, limits = c(-2500,160000)) +
  theme_minimal(base_size = 14, base_family = "Georgia")


