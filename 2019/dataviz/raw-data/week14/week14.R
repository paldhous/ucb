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

nations <- nations %>%
  mutate(year = as.integer(year))

# filter for 2017 data only
nations2017 <- nations %>%
  filter(year == 2017) 

# make bubble chart
ggplot(nations2017, aes(x = gdp_percap, y = life_expect)) +
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

animate(nations_plot)


# gif
nations_anim <- animate(nations_plot, fps = 10, end_pause = 30, width = 750, height = 450)
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

ggplot(warming, aes(x = year, y = value)) +
  geom_line(color = "black") +
  geom_point(shape = 21, 
             color = "black", 
             size = 5, 
             stroke = 1,
             aes(fill = value)) +
  scale_x_continuous(limits = c(1880,2018)) +
  scale_y_continuous(limits = c(-0.5,1)) +
  scale_fill_distiller(palette = "RdYlBu", limits = c(-1,1), guide = FALSE) +
  xlab("") +
  ylab("Difference from 1900-2000 (°C)") +
  theme_minimal(base_size = 16, base_family = "Georgia")


# draw chart
warming_plot <- ggplot(warming, aes(x = year, y = value)) +
  geom_line(color="black") +
  geom_point(shape = 21, 
             size = 5, 
             stroke = 1,
             color = "black", 
             aes(fill = value, group = year)) +
  scale_x_continuous(limits = c(1880,2018)) +
  scale_y_continuous(limits = c(-0.5,1)) +
  scale_fill_distiller(palette = "RdYlBu", limits = c(-1,1), guide = FALSE) +
  xlab("") +
  ylab("Difference from 1900-2000 (°C)") +
  theme_minimal(base_size = 16, base_family = "Georgia") +
  # gganimate code
  transition_reveal(year, keep_last = TRUE) +
  # transition_time(year) +
  shadow_mark()

warming_anim <- animate(warming_plot, fps = 10, end_pause = 30, width = 750, height = 450)
anim_save("warming.gif")


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
  ylab("Diff. from 1900-2000 average (°C)") +
  xlab("") +
  #gganimate code
  ggtitle("{closest_state}") +
  transition_states(
    type,
    transition_length = 1,
    state_length = 4
  ) +
  ease_aes("cubic-in-out")

animate(simulations_plot, width = 750, height = 450)
anim_save("simulations.gif")
