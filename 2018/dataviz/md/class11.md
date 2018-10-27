# Making interactive maps

### Introducing Mapbox Studio

[**Mapbox Studio**](https://carto.com/) is a cloud-based mapping application that makes it easy to produce elegantly styled, interactive, online maps.

### The data we will use today

Download the data from this session from [here](data/week11.zip), unzip the folder and place it on your desktop. It contains the following folders and files:

- `seismic.zip` Zipped shapefile with data on the risk of a damaging earthquake in 2017 for the continental United States, from the [U.S. Geological Survey](https://earthquake.usgs.gov/hazards/induced/).
- `quakes.csv` This file isn't in the folder. As for week 10, we will use the U.S. Geological Survey's [Earthquakes Archives](https://earthquake.usgs.gov/earthquakes/search/) API where we will search for all earthquakes since 1960 with a [magnitude](http://www.geo.mtu.edu/UPSeis/magnitude.html) of 6 or greater that occured witin 6,000 kilometers of the geographic center of the contiguous United States. Type this url into the address bar of your browser:
```Javascript
https://earthquake.usgs.gov/fdsnws/event/1/query?starttime=1960-01-01T00:00:00&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&minmagnitude=6&format=csv&orderby=time
```
A file called `query.csv` should download. Rename it `quakes.csv` and add to the `class11` folder.
- `world.zip` Zipped shapefile including the variable `gdp_percap`, giving World Bank data from 2016 on [Gross Domestic Product (GDP) per capita](https://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) for the world's nations, in current international dollars, corrected for purchasing power in different territories.
- `seismic.html` `gdp2016.html` Web pages for publishing the maps we will make.


### Map seismic risk and earthquakes


### Assignment

File a full project update via your GitHub account, so that I can see your visualizations, data etc. Also write a summary in Markdown, including:

- What you have done
- What you intend to do
- Problems, obstacles

Share this with me by **6pm** on **Wed Nov 8**.

### Further reading/resources





