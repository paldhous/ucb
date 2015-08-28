setwd("~/Dropbox/ucb/2015/dataviz/raw-data/r-week11")

# package to quickly read data into R
library(readr)

# package to draw charts
library(ggplot2)

# package to format axes on those charts as %, $ and so on
library(scales)

# package for manipulating data
library(dplyr)

# package to import data from World Bank World Development Indicators API
library(WDI)

# load food stamps data
food_stamps <- read_csv("food_stamps.csv")

x = c(0,20,40,60)

food_stamps <- food_stamps %>% mutate(bin=.bincode(participants, x))

str(food_stamps)

ggplot(food_stamps, aes(x=year, y=participants)) + geom_line()

# Maybe not
ggplot(food_stamps, aes(x=year, y=participants, color=costs)) + geom_line()

ggplot(food_stamps, aes(x=year, y=participants)) + geom_line() + geom_point()

ggplot(food_stamps, aes(x=year, y=participants)) + geom_line(size=1.5) + geom_point(size=4)

food_stamps_chart <- ggplot(food_stamps, aes(x=year, y=participants))

food_stamps_chart %>%
  + geom_line(size=1.5) %>%
  + geom_point(size=4) %>%
  + xlab("Year") %>%
  + ylab("Participants (millions)")

food_stamps_chart <- food_stamps_chart %>%
  + xlab("Year") %>%
  + ylab("Participants (millions)")

food_stamps_chart %>%
  + geom_line(size=1.5) %>%
  + geom_point(size=4)

food_stamps_chart %>%
  + geom_bar(stat="identity") %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", color="#888888", fill="#cccccc") %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs)) %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs)) %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs)) %>%
  + scale_fill_gradient(low="#fff5f0", high="#67000d") %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradient(low="#fff5f0", high="#67000d") %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradient(name="Costs \n($ billions)", low="#fff5f0", high="#67000d") %>%
  + ggtitle("Column chart")
  
food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradient(name="Costs \n($ billions)", low="#fff5f0", high="#67000d") %>%
  + ggtitle("Column chart")

pal = c("#fee5d9","#fcae91","#fb6a4a","#de2d26")
vals = c(25,50,75)

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradientn(name="Costs \n($ billions)", colours = pal) %>%
  + ggtitle("Food stamp nation")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradientn(name="Costs \n($ billions)", colours = pal, breaks=vals) %>%
  + ggtitle("Food stamp nation")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs)) %>%
  + scale_fill_distiller(name="Costs \n($ billions)", palette="Reds", guide="colorbar") %>%
  + ggtitle("Food stamp nation")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs)) %>%
  + scale_fill_distiller(name="Costs \n($ billions)", palette="Reds", guide="legend") %>%
  + ggtitle("Food stamp nation")

#scale_color_brewer for discrete








save.image("week11.RData")



