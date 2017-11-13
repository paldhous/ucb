# install required packages
devtools::install_github("dgrtwo/gganimate")

# load required packages
library(readr)
library(ggplot2)
library(gganimate)
library(scales)
library(dplyr)

# load data
nations <- read_csv("nations.csv")

# filter for 2015 data only
nations2015 <- nations %>%
  filter(year == 2015)

# make bubble chart
ggplot(nations2015, aes(x = gdp_percap, y = life_expect)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 12, base_family = "Georgia") +
  geom_point(aes(size = population, color = region), alpha = 0.7) +
  scale_size_area(guide = FALSE, max_size = 15) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(formula = y ~ log10(x), se = FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2") +
  theme(legend.position=c(0.8,0.4))

# animate
nations_chart <- ggplot(nations, aes(x = gdp_percap, y = life_expect, frame = year)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  geom_point(aes(size = population, color = region), alpha = 0.7) +
  scale_size_area(guide = FALSE, max_size = 20) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(aes(group = year), formula = y ~ log10(x), se = FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2") +
  theme(legend.position=c(0.8,0.4))

gganimate(nations_chart)

# save as a GIF
gganimate(nations_chart, "nations.gif", ani.width = 750, ani.height = 500, interval = 0.2)

# save as a video 
gganimate(nations_chart, "nations.mp4", ani.width = 800, ani.height = 450, interval = 0.1)

# add delay to final frame of GIF
system("convert nations.gif \\( +clone -set delay 300 \\) +swap +delete  nations_with_pause.gif")

# load data
warming <- read_csv("warming.csv")

# set color palette and sequence of values to apply it to
pal <- c("#313695","#4575b4","#74add1","#abd9e9","#e0f3f8","#ffffbf","#fee090","#fdae61","#f46d43","#d73027","#a50026")
vals <- seq(-2, 2, length = 11)

# draw chart
ggplot(warming, aes(x = year, y = annual)) +
  geom_line(colour="black") +
  geom_point(shape = 21, colour="black", aes(fill=annual), size=5, stroke=1) +
  scale_x_continuous(limits=c(1880,2015)) +
  scale_y_continuous(limits=c(-0.5,1)) +
  theme_minimal() +
  scale_fill_gradientn(colors = pal, values = vals, rescaler = function(x, ...) x, oob = identity, guide=FALSE) +
  xlab("") +
  ylab("Difference from 1951-1980 (ºC)") +
  theme(text=element_text(size=16, family="Georgia"))

# create the animation
warming_chart <- ggplot(warming, aes(x = year, y = annual, frame = year, cumulative = TRUE)) +
  geom_line(colour="black") +
  geom_point(shape = 21, colour="black", aes(fill=annual), size=5, stroke=1) +
  scale_x_continuous(limits=c(1880,2015)) +
  scale_y_continuous(limits=c(-0.5,1)) +
  theme_minimal() +
  scale_fill_gradientn(colors = pal, values = vals, rescaler = function(x, ...) x, oob = identity, guide=FALSE) +
  xlab("") +
  ylab("Difference from 1951-1980 (ºC)") +
  theme(text=element_text(size=16, family="Georgia"))

# run in the viewer
gganimate(warming_chart, interval = 0.1)

# save as GIF and video
gganimate(warming_chart, "warming.gif", ani.width = 750, ani.height = 500, interval = 0.1)
gganimate(warming_chart, "warming.mp4", ani.width = 800, ani.height = 450, interval = 0.1)

# make a list of years, from 1880 to 2015
years <- c(1880:2015)

# loop to make a chart for each year
for (y in years) {
  tmp <- warming %>%
    filter(year <= y)
  chart <- ggplot(tmp, aes(x=year,y=annual)) %>%
    + geom_line(colour="black") %>%
    + geom_point(shape = 21, colour="black", aes(fill=annual), size=5, stroke=1) %>%
    + scale_x_continuous(limits=c(1880,2015)) %>%
    + scale_y_continuous(limits=c(-0.5,1)) %>%
    + theme_minimal() %>%
    + scale_fill_gradientn(colors = pal, values=vals, rescaler = function(x, ...) x, oob = identity, guide=FALSE) %>%
    + xlab("") %>%
    + ylab("Difference from 1951-1980 (ºC)") %>%
    + theme(text=element_text(size=16,family="Georgia"))
  ggsave(file=paste0("charts/",y,".jpg"), plot = chart, width = 8, height = 4.5, units = "in", dpi=300)
  print(paste0("processing: ",y))
}

# combine the maps and charts with ImageMagick, add year label to each frame
for (y in years) {
  system(paste0("convert charts/",y,".jpg maps/map",y,".jpg -geometry +305+68 -composite -pointsize 100 -font Georgia -annotate +2000+1120 ",y," combined/img",y,".jpg"))
  print(paste0("processing: ",y))
}

system("convert -delay 10 combined/*.jpg warming2.gif")


# make a video with FFmpeg
system("ffmpeg -f image2 -start_number 1880 -i combined/img%d.jpg -vf 'scale=trunc(iw/2)*2:trunc(ih/2)*2' -b:a 64000k warming2.mp4")

y
# change the speed of the video
system("ffmpeg -i warming2.mp4 -vf 'setpts=2*PTS' warming3.mp4")


# install and load tweenr
install.packages("tweenr")
library(tweenr)

# prepare data
nations_edit <- nations %>%
  arrange(country, year) %>%
  select(gdp_percap,life_expect,year,country) %>%
  rename(x=gdp_percap,y=life_expect,time=year,id=country) %>%
  mutate(ease="linear")

nations_tween <- tween_elements(nations_edit, "time", "id", "ease", nframes = 300)

# create year and country fields, for join
nations_tween <- nations_tween %>%
  mutate(year = round(time),
         country = .group)

# join
nations_tween <- inner_join(nations_tween,nations)


# make animated chart
nations_tween_chart <- ggplot(nations_tween, aes(x = x, y = y, frame = .frame)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  geom_point(aes(size = population, color = region), alpha = 0.7) +
  scale_size_area(guide = FALSE, max_size = 20) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(aes(group = .frame), formula = y ~ log10(x), se = FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2") +
  theme(legend.position=c(0.8,0.4))

# run in the viewer
gganimate(nations_tween_chart, title_frame = FALSE, interval = 0.05)










