setwd("~/Dropbox/ucb/2015/dataviz/raw-data/r-week11")

# package to quickly read data into R
library(readr)

# package to draw charts
library(ggplot2)

# package to format axes on those charts as %, $ and so on
library(scales)

# package for manipulating data
library(dplyr)

# package to use ColorBrewer color schemes
library(RColorBrewer)

# package to import data from World Bank World Development Indicators API
library(WDI)


# load disease and democracy data
disease_democ <- read_csv("disease_democ.csv")

# go to the web app, and show the code
ggplot(disease_democ, aes(x=infect_rate, y=democ_score)) + geom_point()

str(disease_democ)

head(disease_democ,10)

tail(disease_democ,10)

summary(disease_democ)

disease_democ$infect_rate

write.csv(disease_democ, "disease_democ_copy.csv", row.names = FALSE, na ="")

disease_democ_chart <- ggplot(disease_democ, aes(x=infect_rate, y=democ_score))

disease_democ_chart %>% 
  + geom_point() %>%
  + geom_smooth()

help
# work out how to change the color

# load food stamps data
food_stamps <- read_csv("food_stamps.csv")

str(food_stamps)

#let's draw some charts

food_stamps_chart <- ggplot(food_stamps, aes(x=year, y=participants))  %>%
  + xlab("Year") %>%
  + ylab("Participants (millions)")

food_stamps_chart %>% 
  + geom_line()

food_stamps_chart %>%
  + geom_line() %>%
  + geom_point()

food_stamps_chart %>%
  + geom_line(size=1.5) %>%
  + geom_point(size=4) %>%

food_stamps_chart %>%
  + geom_bar(stat="identity") %>%
  + ggtitle("Column chart")

# Let's start customizing colors

food_stamps_chart %>%
  + geom_bar(stat="identity", color="#888888", fill="#cccccc") %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs)) %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradient(low="#fff5f0", high="#67000d") %>%
  + ggtitle("Column chart")

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradient(name="Costs \n($ billions)", low="#fff5f0", high="#67000d") %>%
  + ggtitle("Column chart")

# Let's use custom colors from ColorBrewer
pal = c("#fee5d9","#fcae91","#fb6a4a","#de2d26")
vals = c(20,40,60)

food_stamps_chart %>%
  + geom_bar(stat="identity", aes(fill=costs), color="888888") %>%
  + scale_fill_gradientn(name="Costs \n($ billions)", colours = pal, breaks=vals) %>%
  + ggtitle("Food stamp nation")

# dplyr

# load pfizer and fda data
pfizer <- read_csv("pfizer.csv")
fda <- read_csv("fda.csv")

# check the dates have been recognized as dates
str(fda)

# introduce conversions

as.character #converts to text string
as.numeric #converts to number
as.factor #converts to categorical variable
as.integer #converts to integer

# introduce select, filter, arrange, group_by, summarize (also rename)

ca_docs <- pfizer %>% select(first_plus, last_name, city, state, category, total) %>%
  filter(category=="Expert-Led Forums" & state=="CA" & total >= 10000) %>%
  arrange(desc(total))

# again, see what happens if miss out the brackets
ca_ny_docs <- pfizer %>% select(first_plus, last_name, city, state, category, total) %>%
  filter(category=="Expert-Led Forums" & (state=="CA"|state=="NY") & total >= 10000) %>%
  arrange(desc(total))

speak_advice <- ca_ny_docs <- pfizer %>% select(first_plus, last_name, city, state, category, total) %>%
  filter(category=="Expert-Led Forums"|category=="Professional Advising") %>%
  arrange(desc(total))

state_totals <- pfizer %>% group_by(state) %>%
  select(state, total) %>%
  summarize(state_total = sum(total)) %>%
  arrange(desc(state_total))

# show count n
state_totals <- pfizer %>% group_by(state) %>%
  select(state, total) %>%
  summarize(state_total = sum(total), count_payments = n()) %>%
  arrange(desc(state_total))

# working with dates
post2005 <- filter(fda, issued >= "2005-01-01") %>%
  arrange(desc(issued))

# subtracting dates is rather easier in R (will get more complicated if you have dates and times)
elapsed <- fda %>% mutate(days_elapsed = Sys.Date()-issued)

# counting letters by year
letters_per_year <- fda %>% group_by(year=format(issued, "%Y")) %>%
  summarize(letters=n())

#join

matches <- inner_join(pfizer, fda, by=c("first_name" = "name_first", "last_name" = "name_last")) %>%
  filter(category=="Expert-Led Forums")

# http://stat545-ubc.github.io/bit001_dplyr-cheatsheet.html

#Come back to after introducing dplyr

#scale_color_brewer for categorical variables

# binning data

quantile(food_stamps$costs,(0:5)/5)
quantile(food_stamps$costs,(1:4)/5)

breaks <- quantile(food_stamps$costs,(0:5)/5)

# explain do need include.lowest=TRUE
food_stamps <- food_stamps %>% mutate(cost_bin=cut(costs, breaks, include.lowest=TRUE)) 

str(food_stamps)

# clean up the names for the bins
levels(food_stamps$cost_bin) <- c("<5.69","5.69-11.8","11.8-20.6","20.6-31.1",">31.1")

food_stamps_chart_2 <- ggplot(food_stamps, aes(x=year, y=participants, fill=cost_bin)) %>%
  + xlab("Year") %>%
  + ylab("Participants (millions)")

food_stamps_chart_2 %>%
  + geom_bar(stat="identity") %>%
  + scale_fill_brewer(name="Costs \n($ billions)") %>%
  + ggtitle("Food stamp nation")

display.brewer.all()

food_stamps_chart_2 %>%
  + geom_bar(stat="identity", aes(fill=cost_bin)) %>%
  + scale_fill_brewer(name="Costs \n($ billions)", palette="Reds") %>%
  + ggtitle("Food stamp nation")

# introduce themes

theme_set(theme_bw())

theme_set(theme_gray())

# run column_theme.R, in each case run the code above

# now back to the ca_docs

theme_set(theme_grey())

ca_docs <- mutate(ca_docs, full_name=paste(first_plus, last_name, sep=" ")) %>%
  mutate(doc_fill=ifelse(grepl("GERALD MICHAEL SACKS", full_name), "Sacks", "Others"))

docs_chart <- ggplot(ca_docs, aes(x=full_name, y=total)) + xlab("") + ylab("Payments") 

docs_chart %>%
  + geom_bar(stat="identity") %>%
  + coord_flip()

docs_chart <- ggplot(ca_docs, aes(x=reorder(full_name, total), y=total)) + xlab("") + ylab("Payments") 

pal2 = c("#a9a9a9","#800000")

docs_chart %>%
  + geom_bar(stat="identity", aes(fill=doc_fill)) %>%
  + scale_fill_manual(values=pal2) %>%
  + scale_y_continuous(label = dollar) %>%  
  + coord_flip() %>%
  + guides(fill=FALSE)

# Greek data

indic_list <- c("SP.DYN.LE00.IN", "SH.XPD.PCAP.PP.KD", "SL.UEM.TOTL.ZS")

indicators <- WDI(indicator=indic_list, country="all", start=1990, end=2014) %>%
  rename(life_expect=SP.DYN.LE00.IN, health_spend=SH.XPD.PCAP.PP.KD, unemploy_rate=SL.UEM.TOTL.ZS) %>% 
  filter(iso2c=="DE"|iso2c=="GR"|iso2c=="RU"|iso2c=="EU")

ggplot(indicators, aes(x=year, y=unemploy_rate, color=country)) + geom_line()

save.image("week11.RData")



