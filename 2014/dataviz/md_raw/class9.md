# Making static maps and processing geodata

### Introducing QGIS

[GQIS](http://qgis.org/en/site/) is the leading free, open source Geographic Information Systems (GIS) program. It is capable of sophisticated geodata processing and analysis, and also can be used to design publication-quality data-driven maps.

The possibilities are almost endless, but you don't need to be a GIS expert to put it to effective use for both displaying geographic data in static maps, and for processing data for use in making interactive online maps.

Today we will learn the basics of displaying and processing data in QGIS, using [this data](./data/qgis.zip).

Launch QGIS, and you should see a screen like this:

![](./img/class9_1.jpg)

### Make a choropleth map showing seismic risk in the continental United States

We will first import a shapefile based on data from the U.S. Geological Survey, detailing [the risk of experiencing a damaging earthquake for the lower 48 states](http://earthquake.usgs.gov/hazards/products/conterminous/index.php#2014). The file is in the subfolder `seismic_risk_clip`.

Select `Layer>Add vector layer` or click on this icon:

![](./img/class9_2.jpg)

At the dialog box, click `Browse` and navigate to the file `seismic_risk_clip.shp`. It is important that you select the file with the `.shp` extension. Then click open, and the following map of the continental United States should appear, filled with a random color:

![](./img/class9_3.jpg)

You can turn off the visibility of any layer by unchecking its box in the `Layers` panel. This can be useful to see the status of layers that would otherwise be obscured.

These controls allow you to pan and zoom the display:

![](./img/class9_32.jpg)

You can focus the display on the full extent of any layer by right-clicking it in the `Layers` panel and selecting `Zoom to layer`.

Notice `EPSG:4326` at the bottom right. This defines the projection for the layer. Right-click on `seismic_risk_clip` in the `Layers` panel at left and select `Properties>General`. You should see the following under `Coordinate reference system`:

![](./img/class9_4.jpg)

`EPSG:4326` and `WGS 84` are two names for the unprojected Equirectangular view we saw in week 8. Strictly speaking, it refers to a datum, not a projection. We will select a projection for our work later. Click `Cancel` or `OK` to close `Properties` for this layer.

Now let's import a basemap for this project. We will use two layers to do this, in the subfolders `ne_50m_admin_0_countries` and `ne_50m_lakes`. Import the shapefiles as before, then drag and drop them in the `Layers` panel so that they appear in the following order:

![](./img/class9_5.jpg)

Having imported all the layers, save your project by selecting `Project>Save` from the top menu. Keep saving your projects at regular intervals.

Now we will style the basemap. Right-click on `ne_50m_admin_0_countries` in the `Layers` panel and select `Properties>Style`. We are going to give the land a single color, so the default `Single Symbol` option from the top dropdown menu is correct. Click on `Simple fill` to call up the following options:

![](./img/class9_6.jpg)

Click on `Colors Fill` to call up the `Select Color` picker. There are a range of options, including a color wheel and RGB sliders. For simplicity, we will use the `Crayons` option and select `Silver`:

![](./img/class9_7.jpg)

Click OK, then repeat the process for `Border`, giving it the color `Snow`. Click OK to close the `Properties` windows, accepting the changes:

![](./img/class9_8.jpg)

We imported `ne_50_m_lakes` to include the Great Lakes on the map, not to show smaller lakes, so in styling the lakes layer we need to filter out the smaller lakes. This means styling according to data values, so we need to look at the table of data attached to this shapefile.

Select `ne_50_m_lakes` in the `Layers` panel, right-click and select `Open Attribute Table`, or click on this icon in the toolbar at top:

![](./img/class9_9.jpg)

This table should open:

![](./img/class9_10.jpg)

Notice that the table contains a field called `scalerank`, in which the largest lakes -- including the Great Lakes -- have the value `0`. This is a categorical variable coded using numbers, like some of the variables from the traffic accidents data we wored with in week 3. Close the table once more.

Right-click on `ne_50_m_lakes` in the `Layers` panel and select `Properties>Style`. Select `Categorized` from the dropdown menu at top, and under `Column` select `scalerank`. Click the `Classify` button, then select everything apart from the symbol with the value `0`:

![](./img/class9_11.jpg)

Click the `Delete` button to remove the other symbols and then bouble-click on the remaining symbol. At the next dialog box select `Simple fill` and change the `Fill` color to `Iron` and the `Border style` to `No Pen`:

![](./img/class9_12.jpg)

To change the background ocean color to match the large lakes, select `Project>Project Properties>General` from the top menu, and the `Background color` to `Iron`:

![](./img/class9_13.jpg)

The map should now look like this:

![](./img/class9_14.jpg)

Now we need to color the areas for the `seismic_risk_clip` layer. Open its attribute table, and notice that it contains a field called `ACC_VAL`. These numbers refer to the ground acceleration predicted for a large quake with a 2% chance of occurring in 50 years, expressed as a percentage of *g*, the acceleration of a body falling under gravity. The numbers go as high as 200, meaning a quake with ground acceleration of twice *g*. The details of the units are unimportant to most people, so we will just divide the data into five categories, from `low` to `high` risk of experiencing a damaging earthquake.

To do this, close the attribute table and call up `Properties>Style` for the `seismic_risk_clip` layer. Select `Graduated` from the dropdown menu at top, which is the option to color data according to a continuous variable. Select `5` under `Classes`, and then `New color ramp...` under `Color ramp`. While QGIS has many available color ramps, we will use this opportunity to call in a [ColorBrewer](http://colorbrewer2.org/) color scheme. At the dialog box select `ColorBrewer` and then `Reds`, and then click `OK`:

![](./img/class9_15.jpg)

You will need to give the color ramp a name -- the default `Reds5` is fine. Select `ACC_VAL` under `Column` and then click the `Classify` button to produce the following display:

![](./img/class9_16.jpg)

Note that the `Mode` dropdown menu gives various options for automatically setting the boundaries between the five classes or bins. However, in this case the choice does not matter because we are going to set these manually.

Double-click on the first symbol and select `19` for the `Upper value` and click `OK`. Then double-click on the `Label` for this symbol and edit the text to `Low`. Carry on editing the values and labels until the display looks like this:

![](./img/class9_17.jpg)

Click on `Change...` then select `Simple fill` and change the `Border style` ro `No Pen` and click `OK`. This will remove the black borders between the areas of color.

Now click `OK` to close the `Properties>Style` window to accept the changes. The map should look like this:

![](./img/class9_18.jpg)

Now is a good time to give the project a projection. As our map is showing areas of high seismic risk for the United States, an Albers Equal Area projection is a good choice.

Select `Project>Project Properties>CRS` (for Coordinate Reference System) from the top menu, and check `Enable 'on the fly' CRS transformation`. This will convert any subsequent layers we import into the Albers projection, also.

Type `Albers `into the `Filter` box and select `NAD83(HARN / Texas Centric Albers Equal Area)`, which has the code `EPSG:3085`:

![](./img/class9_19.jpg)

Click `OK` and the map should reproject. Notice how `EPSG:3085` now appears at bottom right:

![](./img/class9_20.jpg)

### Add a layer showing moderate and large earthquakes over the past 50 years

The data for this layer is in the file `quakes_1964_2013_5+.csv`, and was created using the [USGS earthquakes API](http://earthquake.usgs.gov/earthquakes/search/) we explored in week 5. It includes all earthquakes with a magnitude of 5 and greater from 1964 to 2013 inclusive, in a circle with a radius of 6,000 kilometers from the center of the continental United States.

To import a CSV or other delimited text file with points described by latitude and longitude coordinates, select `Layer>Add Delimited Text Layer` from the top menu or click this icon:

![](./img/class9_21.jpg)

`Browse` to the file with the earthquake data, and check that the dialog box is filled in like this:

![](./img/class9_22.jpg)

(If your file is not a CSV you will have to select the correct delimiter, and if your latitude and longitude fields have other names, you may have to select the `X field` (longitude) and `Y field` (latitude) manually.

When you click `OK` you will be asked to select a projection, or CRS, for the data. You may be tempted to select the same Albers projection we have set for the project, but this will cause an error. QGIS will handle the conversion to that projection: Because this data is not yet projected, we should instead select `WGS 84 EPSG:4326`:

![](./img/class9_23.jpg)

Click `OK` and a large number of points will be added to the map:

![](./img/class9_24.jpg)

Now we will style these points, giving them a single color but sizing them according to the amount of shaking that quake each caused. Open the attribute table for the quakes layer and notice that it contains a field called `mag`, for earthquake magnitude. This is a logarithmic scale, so that a magnitude difference of 1 corresponds to a 10-fold difference in earth movement, as recorded on a seismogram, as [this calculator](http://earthquake.usgs.gov/learn/topics/calculator.php) shows:

![](./img/class9_25.jpg)

This means that the equation to convert magnitude into earthquake "strength," determined by the amplitude of the shaking, is: `Amplitude = 10 ^ Magnitude`.

Select `Properties>Style` for the quakes layer, and accept `Single Symbol` from the top dropdown menu, as we are not going to color the points according to values in the data.

Select `Simple marker`, change the `Fill` to `Snow` and the `Border` to `Iron`.

Then Select `Marker` and adjust the transparency to 50%:

![](./img/class9_26.jpg)

Now click the `Advanced` button to the right and select `Size scaled field`, making sure `Scale area` is checked (this will ensure that the circles we are about to draw scale correctly, by area). Then select `- expression -` and fill in the dialog box as follows:

![](./img/class9_27.jpg)

This incorporates the formula above, and then divides by 200,000 -- which I have found gives a reasonable display. (Usually you will need to experiment with different scaling factors at this point to get a pleasing display.)

The final map should look like this:

![](./img/class9_28.jpg)

### Export finished map in vector graphic formats

We will export our finished map with a legend explaining the colors, so let's change the name of that field so it displays nicely. Right-click on `seismic_risk_clip` in the `Layers` panel, select `Rename` and call it `Seismic risk`.

To export the map, select `Project>New Print Composer`, give the composer an appropriate name and click `OK`. In the print composer window, select the following options in the `Composition` tab:

![](./img/class9_29.jpg)

Now click the `Add new map` icon:

![](./img/class9_30.jpg)

Draw a rectangle over the page area, and the map should appear:

![](./img/class9_31.jpg)

If you are not happy with the display, delete the added map and pan and zoom on the mainb display as appropriate using the pan and zoom controls:

![](./img/class9_32.jpg)

Once you are statisfied with the appearance of your map in the print composer, click the `Add legend` icon:

![](./img/class9_33.jpg)

Draw a rectangle over the map where you want the legend to appear. Don't worry about resizing it for now, because we are going to edit the entries that appear:

![](./img/class9_34.jpg)

In the `Item properties` tab, first delete the `Title` amd then open `Legend items` by clicking on the small triangle next to it:

![](./img/class9_35.jpg)

Select and delete, using the red minus symbol, each of the items apart from `Seismic risk`. Then close `Legend items` by clicking on the small triangle.

Open `Fonts` and change `Font color...` to `Snow`. Notice that the font type and sizes can be customized by clicking on the other buttons.

Uncheck `Background` and resize the legend as necessary, by dragging the white squares:

![](./img/class9_36.jpg)

Finally we will add some text to explain the circles. Click on then `Add new label` icon, and draw a rectangle where you want the text to appear:

![](./img/class9_37.jpg)

Under the `Item properties` tab, type the text in the `Main properties` box and again change the background and adjust the font size as required.

Finally, the map can be exported in SVG and PDF vector formats by clicking these export icons:

![](./img/class9_38.jpg)

(Note that the SVG export will not clip the map to the page exactly. However if you open the SVG in Inkscape and save as a PDF, which will clip to the page, you may get a better rendering of the map than trhough a direct PDF export).

The final map should look like this:

![](./img/class9_39.jpg)

Save the QGIS project, and then select `Project>New` to open a new project.

### Processing geodata with QGIS

In addition to displaying geographic data, QGIS is a powerful tool for processing data for use in the program itself, or by other mapping applications. If you want to make online maps, for instance, as we will do next week, QGIS can help get your data into the right shape. The rest of this class introduces some of QGIS's data-processing functionality, but there is much more to explore -- see the further reading.

### Join external data to a shapefile

In your new project, import the `ne_50m_admin_0_countries` shapefile, then, in the same way, use `Add Vector Layer` to import the file `gdp_pc_join.dbf`. This is the World Bank data on GDP per capita from week 6, in "wide" format, so that the same variable has several columns, one for each year. I opened this data in Libre Office Calc and then saved it as a `dBASE (.dbf)` file -- which as you've learned is the format for shapefile attribute tables. After import, this file will appear as an isolated table in the `Layers` panel. Select it and open the attribute table to view the data:

![](./img/class9_40.jpg)

Notice that null values have been coded as `-99`; this is because the `.dbf` format converts blank cells to zeros. We are going to join the data on the field `ISO2C`. Open the attribute table for the countries shapefile and notice that it contains a matching field called `iso_a2`.

Close the attribute table once more, right-click on the shapefile and select `Properties>Joins`. Click the green plus sign and fill in the dialog box as follows to join the `.dbf` file to the shapefile:

![](./img/class9_41.jpg)

After completing the join, open the shapefile's attribute table once more to confirm that the data from the `.dbf` file has appeared.

(Another approach to joining data to a shapefile would be to perform the join in R or SQLite, like we did in the last query from week 4, and then save this data as the `.dbf` file for the shapefile.)

### Save the joined data in another geodata format

Right-click on the joined shapefile, select `Save As ...` and notice the `Format` options include ESRI shapefile, GeoJSON and KML. You are also able to choose a projection (CRS) for the new shapefile and restrict its extent by latitude and longitude coordinates.

Save this file as GeoJSON with an appropriate name, keeping the default `WGS 84` projection.

### Simplify the joined data, and save again

When displaying geodata online, it is sometimes necessary to simplify boundary data to give a smaller file size, allowing faster loading in a web browser.

Select the joined shapefile, then select `Vector>Geometry Tools>Simplify geometries`, and fill in the dialog box as follows, saving as a shapefile with a new name:

![](./img/class9_42.jpg)

In practice, you will want to experiment with different values for `Simplify tolerance` to give an acceptable trade-off between file size and appearance at high zoom levels.

Save the simplified file as GeoJSON, and compare the file size with the previously saved version.

Alternatively, you can also simplify geodata outside of QGIS using the [mapshaper](http://www.mapshaper.org/) web app.

### Use QGIS's vector geoprocessing tools

Start a new project, and import both the `ne_50m_admin_0_countries` shapefile, and the `seismic_risk` shapefile. This is original version of the file we used to make the seismic risk map, extending beyond the boundaries and coastline of the United States:

![](./img/class9_43.jpg)

Open the attribute table for the countries shapefile, and select the United States:

![](./img/class9_44.jpg)

Close the attribute table once more, and turn off the visibility of the seismic risk layer briefly to confirm that the United States is now highlighted.

Select `Vector>Geoprocessing Tools>Clip` and fill in the dialog box as follows, making sure that `Use only selected features` is checked for the `Clip layer`:

![](./img/class9_45.jpg)

Click `OK` and a new shapefile will be created, clipped to the borders and coastline of the United States. This is how I made the shapefile we used to make the first map.

Sometimes you may need to draw your own shape to clip to, rather than using existing geodata. When drawing shapes based on city streets, [this web app](http://www.birdtheme.org/useful/v3tool.html) can be a useful tool. Select the `Polygon` and `KML` options from the dropdown menu and draw your shape over the basemap.

![](./img/class9_45a.jpg)

Paste the resulting code into a text file and save with the extension `.kml`. You can then use this KML file as a clip layer in QGIS.

Look at the other options in the `Vector>Geoprocessing Tools` menu. Their icons give a good idea of what they do; see [here](http://docs.qgis.org/2.2/en/docs/user_manual/plugins/plugins_ftools.html) for a full explanation. (`Intersect` is similar to `Clip`, except that it includes data from both layers in the new attribute table.)

Now open a new project, and import the shapefile `sf_test_addresses`. I made this shapefile from the addresses we geocoded in Open Refine in week 8, using the coordinates provided by the Bing API. I saved it in a `Google Mercator` projection, also known as `EPSG:900913`, used for Google and other online maps.

This is important, because we are going to create a buffer defining areas within 1,000 feet of the nearest point. For this we need a projection with units defined in distance, rather than degrees, which is the unit for the `WGS 84` datum.

Creating a buffer shapefile is a task you might perform if, for example, working out which areas are off-limits for sex offenders under [residency restrictions](http://www.atsa.com/sexual-offender-residence-restrictions).

Select `Vector>Geoprocessing Tools>Buffer(s)` and fill in the dialog box as follows:

![](./img/class9_46.jpg)

Selecting the maximum value of `99` under `Segments to approximate` ensures that the resulting shapes are as smooth as possible. `Buffer distance` is set to `304.8` because the projection's units are meters; this value gives the 1,000 feet we require. Checking `Dissolve buffer results` merges overlapping buffers into the same polygon.

Click `OK`, and this should be the result:

![](./img/class9_47.jpg)

### Install QGIS plugins

Like the packages that extend R's functionality, QGIS has many plugins that perform specific tasks. We are going to install two useful plugins to complete our geodata processing tutorial.

From the top menu select `Plugins>Manage and Install Plugins...` and search for `MMQGIS`. Select the plugin, and click the `Install plugin` button. Repeat the process for `Points2One`. You should now have an `MMQGIS` menu at top, and the following icon should have appeared in the left toolbar:

![](./img/class9_48.jpg)

### Convert points to lines for North Atlantic storm data

Open a new project, and import the shapefile `storms`, made from the CSV file provided for the North Atlantic storm final project. It consists of points, which we need to turn into tracks for each storm, using the `Points2One` plugin.

To do this, we need a field to uniquely identify each storm, so let's open the attribute table and look at the data. Because names may reused in different years, this doesn't exist. But we can create the field we need by combining `name` and `year`.

To do this, select the `Toggle Editing` icon at top left, which looks like a pencil:

![](./img/class9_49.jpg)

Then click the `Open Field Calculator` icon from the top toolbar, which looks like an abacus:

![](./img/class9_50.jpg)

Fill in the dialog box as follows:

![](./img/class9_51.jpg)

You are hopefully now getting sufficiently familiar with code to realize that here we are "concatenating" the two fields into one, separating them with a hyphen. Note that you must select `Text (string)` for `Output field type`, because "concatenate" is a function that is valid for text strings only. Setting the `Output field width` to `50` ensures that none of the values get truncated.

Click `OK`, then click the `Toggle Editing` icon again and `Save` the change. Open the attribute table to confirm that the new field has been created.

Now click on the `Points2One` icon, and fill in the dialog box as follows:

![](./img/class9_52.jpg)

You may get a warning message. View the details if you wish: It will inform you that a line could not be created for some storms for which there is only a single point.

Accept the option to display on the map, which should now look like this:

![](./img/class9_53.jpg)

Note that most of the entries in the attribute table for the new shapefile will not be valid, as they come from just one of the points used to make each line. If you were to use this file, I suggest opening the `.dbf` file in LibreOffice Calc and deleting eveything apart from the name and year fields, to avoid confusion.

### Use hexagonal binning to summarize data on the Syrian conflict

Open a new project and import the `2013_Q1` shapefile from the `syria_violence` subfolder. This displays violent events in Syria's civil war from the first quarter of 2013, as displayed on [this interactive](http://syria.newscientistapps.com/), and is in a `Google Mercator` projection.

If you open the attribute table for this shapefile, you will see it contains more than 10,000 entries -- so clearly many of the points are lying over the top of one another.

We will use the `MMQGIS` plugin to create a hexagonal grid over the map, and then count the number of points in each grid cell, to get a better picture of the intensity of the conflict by location.

First use the zoom and pan controls to ensure that there is a little space around the points in the displayed area, giving a view something like this:

![](./img/class9_54.jpg)

Select `MMQGIS>Create>Create Grid Layer` and fill in the dialog box as follows:

![](./img/class9_55.jpg)

`Center X `and `Middle Y` will by default be the longitude and latitutude for the center of the displayed area. Make sure to select `Hexagon (polygon)`, and then set the `H Spacing`; `V Spacing` will adjust automatically. Because we are working with a shapefile in `Google Mercator` projection, the units will be in meters, so here we have set a horizonatal spacing for the hexagons of 20 kilometers; if we were working with an unprojected file in the `WGS 84` datum, the units would be in degrees.

Click `OK` to create the grid layer, giving it the same `Google Mercator` projection. Drag the new grid layer under the points in the `Layers` panel and the map should look like this:

![](./img/class9_56.jpg)

Now select `Vector>Analysis Tools>Points in Polygon` and fill in the dialog box as follows:

![](./img/class9_57.jpg)

This will create a new shapefile with a field `PNTCNT`, giving the number of points in each cell in the grid. Again, give this a `Google Mercator` projection. This shapefile can now be used to make maps like this:

![](./img/class8_18.jpg)

### Assignment

Use the shapefile we created in class with World Bank data on GDP per capita to replicate this map, from week 1:

![](./img/class1_9.jpg)

Send me the finished map as a PDF.

Some notes on how to approach this:

* You will need to change to a `World_Robinson EPSG:54030` projection. When you do so, you may find the map transforms to a series of geometric shapes. If this happens, right-click on the layer, select `Properties>Rendering` and uncheck `Simplify geometry`.

* When styling the map, use a ColorBrewer sequential color scheme with 5 classes. Then use the `Add class` button to add a class/bin for the countries with no data. Remember that these will have the value `-99`, so you can then set the values and labels for each bin in the data manually. Use a neutral gray for the countries with no data.

### Further reading

[QGIS Training Manual](http://docs.qgis.org/2.2/en/docs/training_manual/)

[QGIS User Guide](http://docs.qgis.org/2.2/en/docs/user_manual/)

[A Gentle Introduction to GIS](http://docs.qgis.org/2.2/en/docs/gentle_gis_introduction/)




















