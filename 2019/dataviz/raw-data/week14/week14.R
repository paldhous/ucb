# first install devtools
install.packages("devtools")

# then gganimate
devtools::install_github('thomasp85/gganimate')

# and transformr
devtools::install_github("thomasp85/transformr")

#### Load the packages we will use today

# load required packages
library(readr)
library(ggplot2)
library(gganimate)
library(scales)
library(dplyr)
library(tidyr)

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

# animate entire time series with gganimate
nations_plot <- ggplot(nations, aes(x = gdp_percap, y = life_expect)) +
  xlab("GDP per capita") +
  ylab("Life expectancy at birth") +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  geom_point(aes(size = population, color = region), alpha = 0.7) +
  scale_size_area(guide = FALSE, max_size = 15) +
  scale_x_continuous(labels = dollar) +
  stat_smooth(formula = y ~ log10(x), se = FALSE, size = 0.5, color = "black", linetype="dotted") +
  scale_color_brewer(name = "", palette = "Set2") +
  theme(legend.position=c(0.8,0.4)) +
  # gganimate code
  ggtitle("{frame_time}") +
  transition_time(year) +
  ease_aes("linear") +
  enter_fade() + # explain the alternatives
  exit_fade()

  shadow_wake() +
  shadow_wake()
  
animate(nations_plot)

# gif
nations_anim <- animate(nations_plot, fps = 10, width = 750, height = 450)
anim_save("nations.gif") 

# video
nations_anim <- animate(nations_plot, renderer = ffmpeg_renderer(), width = 800, height = 450)
anim_save("nations.mp4") 

# increase delay on final frame of gif
system("convert nations.gif \\( +clone -set delay 300 \\) +swap +delete  nations_with_pause.gif")

# slow down the video
system("ffmpeg -i nations.mp4 -vf 'setpts=2*PTS' nations_slow.mp4")


# individual frames 
nations_anim <- animate(nations_plot, device = "png", width = 750, height = 450, renderer = file_renderer("~/Desktop/gganim", prefix = "gganim_plot", overwrite = TRUE))
anim_save()

####

# load data
warming <- read_csv("https://www.ncdc.noaa.gov/cag/global/time-series/globe/land_ocean/ytd/12/1880-2017.csv", skip=4)
names(warming) <- c("year","value")
write_csv(warming, "warming.csv", na="")

# load
warming <- read_csv("warming.csv")
glimpse(warming)

# draw chart
warming_plot <- ggplot(warming, aes(x = year, y = value)) +
  geom_line(colour="black") +
  geom_point(shape = 21, colour = "black", aes(fill = value), size=5, stroke=1) +
  scale_x_continuous(limits = c(1880,2017)) +
  scale_y_continuous(limits = c(-0.5,1)) +
  scale_fill_distiller(palette = "RdYlBu", limits = c(-1,1), guide = FALSE) +
  xlab("") +
  ylab("Difference from 1900-2000 (ºC)") +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  # gganimate code
  transition_reveal(id = 1, along = year) +
  transition_time(year) +
  shadow_mark()

warming_anim <- animate(warming_plot, fps = 10, width = 750, height = 450)
anim_save("warming.gif")

# draw chart
warming_points <- ggplot(warming, aes(x = year, y = value)) +
  geom_point(shape = 21, colour = "black", aes(fill = value), size=5, stroke=1) +
  scale_x_continuous(limits = c(1880,2017)) +
  scale_y_continuous(limits = c(-0.5,1)) +
  scale_fill_distiller(palette = "RdYlBu", limits = c(-1,1), guide = FALSE) +
  xlab("") +
  ylab("Difference from 1900-2000 (ºC)") +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  # gganimate code
  transition_time(year) +
  shadow_mark()

warming_anim <- animate(warming_points, fps = 10, width = 750, height = 450)
anim_save("warming_points.gif")


# so we need to write a loop and save out the individual frames

# make a list of years, from 1880 to 2017
years <- c(1880:2017)

# loop to make a chart for each year
for (y in years) {
  tmp <- warming %>%
    filter(year <= y)
  chart <- ggplot(tmp, aes(x = year, y = value)) + 
    geom_line(colour = "black") +
    geom_point(shape = 21, colour="black", aes(fill = value), size = 5, stroke = 1) +
    scale_x_continuous(limits = c(1880,2017)) +
    scale_y_continuous(limits = c(-0.5,1)) +
    scale_fill_distiller(palette = "RdYlBu", limits = c(-1,1), guide = FALSE) +
    xlab("") +
    ylab("Difference from 1900-2000 (ºC)") +
    theme_minimal(base_size = 16, base_family = "Georgia")
  ggsave(file = paste0("charts/",y,".jpg"), plot = chart, width = 8, height = 4.5, units = "in", dpi = 300)
  print(paste0("processing: ",y))
}  

# make a GIF with ImageMagick
system("convert -delay 10 charts/*.jpg warming2.gif") # on windows shell

# make a video with FFmpeg
system("ffmpeg -f image2 -start_number 1880 -i charts/%d.jpg -vf 'scale=trunc(iw/2)*2:trunc(ih/2)*2' -b:a 64000k warming.mp4")

# change the speed of the video
system("ffmpeg -i warming.mp4 -vf 'setpts=2*PTS' warming_slow.mp4")


#### climate forcings

# load model simulation data
simulations <- read_csv("https://www.bloomberg.com/graphics/2015-whats-warming-the-world/data/forcings.csv") %>%
  filter(between(Year, 1880, 2005)) %>%
  rename(`Earth’s orbit` = `Orbital changes`,
         Aerosols = `Anthropogenic tropospheric aerosol`,
         `Solar radiation` = Solar)

# calculate average for 1900-2000 baseline from simulations
baseline <- simulations %>%
  filter(between(Year, 1900, 2000)) %>%
  select(2:11) %>%
  summarise_all(mean)

# subtract these values from the simulation data
years <- data_frame(Year = 1880:2005)
years <- cbind(years,baseline)
simulations <- simulations[2:11]-years[2:11] 
simulations <- simulations %>%
  mutate(Year=1880:2005) %>%
  gather(Type, Value, -Year) 

# combined natural vs. combined human factors
hum_nat <- simulations %>%
  filter(grepl("Natural|Human",Type))
names(hum_nat) <- c("year","type","value")

write_csv(hum_nat,"simulations.csv")

simulations <- read_csv("simulations.csv")

simulations_plot <- ggplot(simulations, aes(x=year, y=value, color = value)) +
  geom_line(size = 1) +
  theme_dark(base_size = 16, base_family = "Georgia") +
  scale_y_continuous(limits = c(-0.6,0.75)) +
  scale_colour_distiller(palette = "RdYlBu", limits = c(-1,1), guide = FALSE) +
  ylab("Diff. from 1900-2000 average (ºC)") +
  xlab("") +
  #gganimate code
  ggtitle("{closest_state}") +
  transition_states(
    type,
    transition_length = 0.5,
    state_length = 2
  ) +
  ease_aes("cubic-in-out")

animate(simulations_plot, width = 750, height = 450)
anim_save("simulations.gif")


