# Making static maps and processing geodata with GIS

### Introducing QGIS

[**GQIS**](https://qgis.org/en/site/) is the leading free, open source Geographic Information Systems (GIS) application. It is capable of sophisticated geodata processing and analysis, and also can be used to design publication-quality data-driven maps.

The possibilities are almost endless, but you don't need to be a GIS expert to put it to effective use for both displaying and processing geographic data, whether for online or print maps.

Launch QGIS, and you should see a screen like this:

![](./img/class10_1.jpg)

(Ignore the suggestion to download a new QGIS version: It currently has a bug on MacOS, which is why we are using version 3.0.)

If your screen looks different, select `View>Panels` from the top menu and check the options as follows:

![](./img/class10_1b.jpg)

Then select `View>Toolbars` and check the options as follows:

![](./img/class10_1c.jpg)


### The data we will use today

Download the data from this session from [here](data/week10.zip), unzip the folder and place it on your desktop. It contains the following folders and files:

- `seismic` Shapefile with data on the risk of a damaging earthquake in 2017 for the continental United States, from the [U.S. Geological Survey](https://earthquake.usgs.gov/hazards/induced/).
- `seismic_raw` As above, but not clipped to the coast and borders of the United States.
- `gdp_pc`
 - `gpd_pc.csv` `gdp_pc.csvt` CSV file with [World Bank data](http://data.worldbank.org/indicator/NY.GDP.PCAP.PP.CD) on GDP per capita for the world's nations in 2016, plus ancillary file for QGIS to understand the data types for each field.
- `ne_50m_admin_0_countries_lakes` [Natural Earth shapefile](http://www.naturalearthdata.com/downloads/50m-cultural-vectors/50m-admin-0-countries-2/) with boundary data for the world's nations.
- `sf_test_addresses` Shapefile derived from the addresses we geocoded in week 9.
- `quakes.csv` This file isn't in the folder. Instead, we will
use the U.S. Geological Survey's [Earthquakes Archives](https://earthquake.usgs.gov/earthquakes/search/) API where we will search for all earthquakes since 1960 with a [magnitude](http://www.geo.mtu.edu/UPSeis/magnitude.html) of 6 or greater that occured witin 6,000 kilometers of the geographic center of the contiguous United States, which [this site](https://tools.wmflabs.org/geohack/geohack.php?pagename=Geographic_center_of_the_contiguous_United_States&params=39.828175_N_98.579500_W_region:US_type:landmark) tells us lies at a latitude of `39.828175` degrees and a longitude of `-98.5795` degrees. Type this url into the address bar of your browser:
```Javascript
https://earthquake.usgs.gov/fdsnws/event/1/query?starttime=1960-01-01T00:00:00&latitude=39.828175&longitude=-98.5795&maxradiuskm=6000&minmagnitude=6&format=csv&orderby=time
```
A file called `query.csv` should download. Rename it `quakes.csv` and add to the `week10` folder.

### Map seismic risk and earthquakes

#### Make a choropleth map showing seismic risk for the continental United States

As we discussed in week 9, choropleth maps fill areas with color, according to values in the data.

We will first import the shapefile in the `seismic` folder.

Select `Layer>Add Layer>Add Vector Layer...` or click on this icon:

![](./img/class10_2.jpg)

At the dialog box, click the button with the three dots under `Source` and navigate to the file `seismic`. It is important that you select the file with the `.shp` extension. Then click `Add` and `Close` and the following map should appear, filled with a random color:

![](./img/class10_3.jpg)

The `Layers` panel on the left should now show the `seismic` layer. You can turn off the visibility of any layer by unchecking its box in the `Layers` panel. This can be useful to see the status of layers that would otherwise be obscured.

These controls allow you to pan and zoom the display:

![](./img/class10_4.jpg)

You can focus the display on the full extent of any layer by right-clicking it in the `Layers` panel and selecting `Zoom to layer`.

Notice `EPSG:4326` at the bottom right. This defines the map projection and datum for the layer.

Right-click on `seismic` in the `Layers` panel at left and select `Properties>Source`. You should see the following under `Coordinate reference system`:

![](./img/class10_5.jpg)

`EPSG:4326` and `WGS84` mean that this shapefile is in an [equirectangular projection](http://en.wikipedia.org/wiki/Equirectangular_projection), and the [WGS84](https://en.wikipedia.org/wiki/World_Geodetic_System) datum. This is also the default for QGIS if no projection is specified.

We will select another projection for our map later. Click `Cancel` or `OK` to close `Properties` for this layer.

Now we need to color the areas for the `sesimic` layer by values in the data. Right-click on the layer in the `Layers` panel and select `Open Attribute Table`, which corresponds to the `.dbf` of the shapefile:

![](./img/class10_6.jpg)

There is one variable, `ValueRange`, which gives ranges for the percentage chance of experiencing a damaging quake in 2017.

Close the attribute table and open `Properties>Symbology` for the `seismic` layer. Select `Categorized` from the dropdown menu at top, which is the option to color data according to values of a categorical variable, and then select `ValueRange` under `Column`.

(Note, although these values are percentages, they have already been binned into categories in this data. If we were coloring by a continuous variable that had not already been binned, we would select `Graduated` and select values for the bins. See [this previous class](https://paldhous.github.io/ucb/2016/dataviz/week10.html) for an example.)

Click the `Classify` button and the values in the data will be assigned random colors:

![](./img/class10_7.jpg)

Notice that the range `10-12` is out of order, and we also have a blank range at the bottom. First select this blank and click the red minus symbol to remove it. Now click and drag the range `10-12` to the correct position.

![](./img/class10_8.jpg)

Now click on the `Color ramp` dropdown menu, select `Create New Color Ramp, and at the next dialog box select `Catalog: ColorBrewer`:

![](./img/class10_9.jpg)

Select the ColorBrewer `Reds` palette, click `OK`, and the map should look like this:

![](./img/class10_10.jpg)

Next we'll remove the black outlines around the polygons. Open `Properties>Symbology` again, and click on the colored square under `Symbol`. Select `Simple fill` in the dialog box, and change `Stroke style` to `No Pen`:

![](./img/class10_12.jpg)

Click on `OK` at each of the dialog boxes and the map should now look like this:

![](./img/class10_13.jpg)

It is also possible to edit the colors for each value individually.

If you are likely to want to style data with the same column headings in the same way in future, click the `Style` button in `Properties>Symbology` and select `Save Style>QGIS Layer Style File...`. This saves the style in `QML`, which is a variant of [XML](https://www.w3.org/XML/). When loaded using the `Style>Load Style`, it will automatically apply the saved styling to future maps.

Now is a good time to give the project a projection: We will use a variant of the [Albers Equal Area Conic projection](http://en.wikipedia.org/wiki/Albers_projection), optimized for maps of North America.

Select `Project>Project Properties>CRS` (for Coordinate Reference System) from the top menu, type `Albers `into the `Filter` box and select `North_America_Albers_Equal_Area_Conic`, which has the code `EPSG:102008`:

![](./img/class10_14.jpg)

Click `OK` and the map should reproject. Notice how `EPSG:102008` now appears at bottom right. Right-click on the layer and `Zoom to Layer` so that the view is optimized for this projection:

![](./img/class10_15.jpg)

Save the project, by selecting `Project>Save` from the top menu.

#### Add a base layer showing countries

Add the `ne_50m_admin_0_countries_lakes` layer, as before. It will appear above our choropleth map:

![](./img/class10_16.jpg)

So click and drag the `ne_50m_admin_0_countries_lakes` layer below the `seismic` layer in the `Layers Panel`.

![](./img/class10_17.jpg)

Now open up `Properties>Symbology` for the `ne_50m_admin_0_countries_lakes` layer, select `Simple fill`, and click on the `Fill` color to change it to `#cccccc` for a light gray. Also change the `Outline` to `#ffffff` for white:

![](./img/class10_18.jpg)

Click `OK` and the map should look like this:

![](./img/class10_19.jpg)

Now select `Project>Project Properties...>General`, click on the `Background color` and set it to `#686868` for a dark gray:

![](./img/class10_20.jpg)

The map should now look like this:

![](./img/class10_21.jpg)

#### Add the earthquakes layer

To import a CSV or other delimited text file with points described by latitude and longitude coordinates, select `Layer>AddLayer>Add Delimited Text Layer` from the top menu or click this icon:

![](./img/class10_22.jpg)

Navigate to the file `quakes.csv`, and ensure that the dialog box is filled in like this:

![](./img/class10_23.jpg)

If your text file is not a CSV you may have to select the correct delimiter, and if your latitude and longitude fields have other names, you may have to select the `X field` (longitude) and `Y field` (latitude) manually.

==**Important:**== Do not change the CRS, or projection to the same Albers projection we have set for the project, but this will cause an error. QGIS will handle the conversion to that projection: Because the data in the CSV file is not yet projected, so stick with the default equirectangular projection `WGS 84 EPSG:4326` at this dialog box.

Click `Add` and a large number of points will be added to the map:

![](./img/class10_25.jpg)

Now we will style these points, giving them a single color but sizing them according to the amount of shaking that quake each caused. Open the attribute table for the quakes layer and notice that it contains a variable called `mag`, for earthquake magnitude. This is a logarithmic scale, so that a magnitude difference of 1 corresponds to a 10-fold difference in earth movement, as recorded on a seismograph, as [this calculator](https://earthquake.usgs.gov/learn/topics/calculator.php) shows:

![](./img/class10_26.jpg)

This means that the equation to convert magnitude into the amplitude of the shaking, as recorded on a seismograph, is `amplitude = 10^magnitude`, or ten raised to the power of magnitude.

So if we want to scale the points according to the actual size of the quake, we need to create a new field in the data for amplitude. To do this, click on the abacus symbol in the top toolbar:

![](./img/class10_27.jpg)

Fill in the dialog box as follows:

![](./img/class10_28.jpg)

The formula  is: `amplitude = 10^mag/100000`. The final division by 100,000 helps keep the values in a range that is easy to read and understand, which will help when we set the size of the points. The `Output preview` at the bottom shows the resulting value for the first row in the attribute table. Click `OK` to create the new `amplitude` variable.

Select `Properties>Symbology` for the `quakes` layer, set the `Color` to `#ffffff` for white and the `transparency` to `50%`:

![](./img/class10_29.jpg)

Now click on this icon for `Size`, and select `Assistant...`:

![](./img/class10_30.jpg)

Fill in the dialog box as follows:

![](./img/class10_31.jpg)

Using the `Scale method` of `Surface` will scale the circles by area, according to values in the data; `Flannery` is a [method of scaling](https://makingmaps.net/2007/08/28/perceptual-scaling-of-map-symbols/) that is designed to compensate for the errors people make when estimating the area of circles. You may wish to experiment with this, but I would strongly advise against using `Radius`, for the reasons we discussed in week 2.

By default, QGIS will select the range of values in the data, when you hit the refresh icon:

![](./img/class10_31b.jpg)

Make sure to set both `Size from` and `Values from` to zero to ensure that the area of the points scales accurately according to values in the data.

Click `OK` until you return to the map, which should now look like this:

![](./img/class10_32.jpg)

#### Export the finished map in raster image or vector graphic formats

To export the map as a JPG, PNG, or other raster image format, select `Project>Save Map as Image...` from the top menu.

Exporting using `Project>Save Map as PDF` will give a vector graphic that can be further edited in [Adobe Illustrator](http://www.adobe.com/products/illustrator.html) or another vector graphic editing program.

To export as a vector graphic with other features, select `Project>New Print Laout`, give the composer an appropriate name and click `OK`. Set `Page size` as required, then click the `Add new map` icon:

![](./img/class10_33.jpg)


Draw a rectangle over the page area, and the map should appear. At this point, you may need to alter the zoom level and position of your map in the main QGIS display to get a pleasing display in the print layout.

Your print layout should now look something like this:

![](./img/class10_34.jpg)

The print layout also allows you to add and edit a legend, by clicking this icon:

![](./img/class10_35.jpg)

You can also add text and other items. In practice, however, you may find it easier to add legends and labels in Adbobe Illustrator.

The map can be exported in SVG and PDF vector formats by clicking these export icons:

![](./img/class10_36.jpg)

Finally, save the QGIS project.

#### Join external data to a shapefile

Open a new project by selecting `Project>New` from the top menu.

In this new project, import the `ne_50m_admin_0_countries_lakes` shapefile. Right-click on it in the `Layers` panel and `Save As ...` an `ESRI shapefile`, keeping the default `WGS 84` CRS. `Browse` to the `gdp_pc` folder, call the new file `gdp_pc` and check the option to `Add saved file to map`.

Now remove the original shapefile, by right-clicking on that layer and selecting `Remove`.

Open the attribute table of the new shapefile and notice that it contains a field called `iso_a3`, which is a [three-letter code](https://unstats.un.org/unsd/tradekb/Knowledgebase/Country-Code) for each country, assigned by the [International Organization for Standardization](https://www.iso.org/iso/home/store/catalogue_tc/catalogue_detail.htm?csnumber=63545).

Now use `Add Vector Layer` to import the file `gdp_pc.csv`. (Note that when joining external data in a CSV file to a shapefile, you do *not* import the file as a delimited text file, as we did previously to display data on a map.)

After import, this file will appear as an isolated table in the `Layers` panel.

![](./img/class10_37.jpg)

Select it and open the attribute table to view the data, which contains country names, the three-letter country codes, and data on GDP per capita in 2016:

![](./img/class10_38.jpg)

Notice that some cells contain the value `-99`, which is here being used to designate `null` values, where there is no data.

The same subfolder with the file also contains the file `gdp_pc.csvt`. This contains information about the type of data in each field of the CSV file, in this case:

```r
"String","String","Real"
```

When we make the join, this will tell QGIS what sort of data is in each field of the CSV file. `String` indicates a string of text, `Real` indicates numbers that can include decimals, while `Integer` indicates whole numbers. Without this information, QGIS will treat all of the fields in the file as text.

Close the attribute table once more, right-click on the `gdp_pc` shapefile and select `Properties>Joins`. Click the green plus sign and fill in the dialog box as follows to join the CSV file to the shapefile by the `iso_a3` three-letter country codes:

![](./img/class10_39.jpg)

Click `OK` at each dialog box to complete the join, then open shapefile's attribute table once more to confirm that the data from the CSV file has appeared.

#### Save the joined data in another geodata format

Right-click on the joined shapefile, select `Save As ...` and notice the `Format` options include ESRI shapefile, GeoJSON and KML. You are also able to choose a projection (CRS) for the new file and restrict its extent by latitude and longitude coordinates.

Save this file in the `gpd_pc` folder as GeoJSON with an appropriate name, keeping the default `WGS 84` CRS.

#### Use QGIS's vector geoprocessing tools

Start a new project, and import both the `ne_50m_admin_0_countries_lakes` shapefile, and the `seismic_raw` shapefile. Note that it extends beyond the boundaries and coastline of the U.S.:

![](./img/class10_40.jpg)

Turn off the visibility of the  `seismic_raw` layer, turn on the visibility of the `ne_50m_admin_0_countries_lake` layer, select it in the `Layers Panel`, and click the `Select feature(s)` button:

![](./img/class10_41.jpg)

Now click anywhere within the borders of the United States to select the nation, which should now appear yellow:

![](./img/class10_42.jpg)

Select `Vector>Geoprocessing Tools>Intersection` from the top menu and fill in the dialog box as follows:

![](./img/class10_43.jpg)

Click `Run in Background` and a new layer will be created, clipped to the borders and coastline of the United States:

![](./img/class10_44.jpg)

Its attribute table will contain data from both layers used for the intersection.

You can now right-click on the new `Intersection` layer and `Save As ...` as a shapefile, GeoJSON, or another geodata format.

Look at the other options in the `Vector>Geoprocessing Tools` menu. Their icons give a good idea of what they do. (`Clip` is similar to `Intersection`, except that it does not include data from both layers in the new attribute table.)

Now open a new project, and import the shapefile `sf_test_addresses`. I made this shapefile from the addresses we geocoded in week 9. I saved it in a `Web Mercator` projection, also known as `EPSG:3857`, commonly used for online maps.

This is important, because we are going to create a "buffer" defining areas within 1,000 feet of the nearest point. For this we need a projection with units defined in distance, rather than degrees, which is the unit for the `WGS 84` datum.

To confirm the units for the `Web Mercator` projection, click on the button showing the CRS at bottom-right:

![](./img/class10_45.jpg)

You should see that the CRS/projection information that appears near the bottom of the dialog box contains `+units=m`, which tells us that distances in this projection are measure in meters:

![](./img/class10_46.jpg)

Creating a buffer shapefile is a task you might perform if, for example, working out which areas are off-limits for sex offenders under [residency restrictions](http://www.atsa.com/pdfs/Policy/2014SOResidenceRestrictions.pdf).

Select `Vector>Geoprocessing Tools>Fixed distance buffer` and fill in the dialog box as follows:

![](./img/class10_47.jpg)

Selecting `99` under `Segments to approximate` ensures that the resulting shapes are as smooth circles. `Buffer distance` is set to `304.8` because the projection's units are meters; this value gives the 1,000 feet we require. Checking `Dissolve result` merges overlapping buffers into the same polygon.

Click `Run in Background`, and this should be the result:

![](./img/class10_48.jpg)

Again, you can now right-click on the new `Buffer` layer and `Save As ...` as a shapefile, GeoJSON, or another geodata format.

### Assignment

File an update on progress with your final project. Pay particular attention to identifying problems/obstacles.

You can file the update as a markdown file in GitHub. Either way, make sure that your GitHub repo is up to date with data, charts etc, so that I can sync with my version of your project and review your progress. The update should be sufficiently detailed that I can look at your repo and understand what you are doing.

If you are having trouble with GitHub, get in contact for a refresher.

### Further reading

[QGIS Training Manual](https://docs.qgis.org/testing/en/docs/training_manual/index.html)

[QGIS User Guide](https://docs.qgis.org/testing/en/docs/)

[A Gentle Introduction to GIS](https://docs.qgis.org/testing/en/docs/gentle_gis_introduction/index.html)


