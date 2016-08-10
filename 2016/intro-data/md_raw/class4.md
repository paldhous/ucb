# Interviewing data: Making charts and maps

In this week's class we will make a series of charts and maps, to answer specific questions about two datasets, to help shape future reporting. While the main goal here is exploratory data analysis -- i.e. interviewing our data -- we will also learn how to embed the graphics we make into an online story package.

### The data we will use today

Download the data for this session from [here](data/week4.zip), unzip the folder and place it on your desktop. It contains the following files:

- `richmond_collisions.xls` Data on injury and fatal traffic accidents in Richmond, California, from 2005 to 2013, from the [Transportation Injury Mapping System](http://tims.berkeley.edu/page.php?page=about). The data comes from the California Highway Patrol’s [Statewide Integrated Traffic Records System](http://iswitrs.chp.ca.gov/Reports/jsp/userLogin.jsp) and was then geocoded for mapping by UC Berkeley’s Safe Transportation Research & Education Center. This is the data we cleaned in Open Refine in Week 2.

- `urban_displacement.xlsx` Data on gentrification in the Bay Area, from the [Urban Displacement Project](http://www.urbandisplacement.org/), an initiative of UC Berkeley, in collaboration with researchers at UCLA. The project has compiled socioeconomic data for each [census tract](https://www.census.gov/geo/reference/gtc/gtc_ct.html) in the Bay Area, and used this to rate the degree of exclusion or displacement experienced by low-income households in each. See [here](http://www.urbandisplacement.org/sites/default/files/images/urban_displacement_project_-_executive_summary.pdf) for an executive summery of the project's findings. The variables measured are documented in the first sheet of this spreadsheet, the full data is in the second.


### Introducing Tableau Public and Google Fusion Tables

In this week's class we will work with [**Tableau Public**](http://www.tableausoftware.com/public/), which allows you to create a wide variety of interactive charts, maps and tables and organize them into **dashboards** that can be saved to the cloud and embedded on the web.

Tableau was developed for exploratory graphical data analysis, so it is a good tool for exploring a new dataset -- **filtering**, **sorting** and **aggregating** the data in different ways while experimenting with various chart types.

Although Tableau was not designed as a publication tool, the ability to embed finished dashboards and stories has also allowed newsrooms that lack JavaScript coding expertise to create interactive online graphics.

We will also use **[Fusion Tables](https://support.google.com/fusiontables/answer/2571232?hl=en)**, described by Google as "an experimental data visualization web application to gather, visualize, and share data tables." It can function as a simple online database, allowing you to **filter** data tables, and to **join** tables together by common fields. Most usefully, it provides a simple way to make customized interactive online maps.


### Visualize data on fatal and injury traffic accidents in Richmond

Open Tableau Public, and you should see a screen like this:

![](./img/class4_1.jpg)

#### Questions to ask of this data

Here are the questions that we will seek to answer with this graphical analysis:

- Where did each collision that caused death or injury occur, and how many people were killed and injured in each one?

- For each collision, was alcohol involved?

- How many deaths and injuries occured in each year, and for how many of these was alcohol involved?


#### Connect to the data

The Richmond traffic accident data is in an Excel file. So from the left panel select `Connect>Excel`. Navigate to the file `richmond_collisions.xls` and `Open`. At this point, you can view the data, which will be labeled as follows:

 - **Text:** `Abc`
 - **Numbers:** `#`
 - **Dates:** calendar symbol
 - **Geography:** globe symbol

![](./img/class4_2.jpg)

Tableau doesn't always recognize entries correctly, but if necessary you can edit fields to give them the correct data type:

![](./img/class4_3.jpg)

After our cleaning in Open Refine, however, the data we are going to use should be formatted correctly.

Once the data has loaded, click `Sheet 1` at bottom left and you should see a screen like this:

![](./img/class4_4.jpg)

#### Dimensions and measures

Notice that Tableau has divided the variables into `Dimensions` and `Measures`. If the variables are all classified correctly, these broadly correspond to categorical and continuous variables. `Dimensions` are variables containing text or dates, while `Measures` contain numbers.

#### Shelves and Show Me

You make charts and maps in Tableau by dragging variables from the `Data` panel at left onto the "shelves" in the main charts area. These are marked `Columns`, `Rows`, `Pages`, `Filters`, and so on.

The `Show Me` panel at top right shows the charts that you can make, from the data currently beinf used, and also tells you the combinations of `Dimensions` and `Measures` needed for each chart type. You can hide or show this panel at any time by clicking on its header bar.


#### Columns and rows: X and Y axes

The starting point for creating any chart or map in Tableau is to place fields into the `Columns` and `Rows` shelves, which for most charts correspond to the X (horizontal) and Y (vertical) axes, respectively. When making maps, longitude is the X axis and latitude the Y. If you display the data as a table, then these labels are self-explanatory.

#### Calculate the number of people killed and injured in each collision

Again, as for our spreadsheet exercise with this data, we need to make a new variable giving the number of people killed and injured in each collision.

Select `Analysis>Create calculated field...` from the top menu and fill in the dialog box as follows:

![](./img/class4_5.jpg)

When you start to type in the name of a variable into the dialog box, you should get the opportunity to select it. Do so, and the variable will appear in square brackets in the formula.

When calculating new variables, you can use **functions**, as in Google Sheets. You can review all of the avilable functions in Tableau by clicking the little right-facing triangle at the right of the dialog box:

![](./img/class4_6.jpg)

Notice that the new calculated variable appears in the `Data` panel, prefixed by an `=` symbol

#### Map the location of each collision

We will now place all the collisions as points on a map. Drag `Longitude` to `Columns` and `Latitude` to `Rows`.

The screen should now look like this:

![](./img/class4_7.jpg)

Why is there a single point, somewhere in Arizona? Look at `Columns` and `Rows`, and notice that, by default, Tableau has **aggregated** all the longitudes and latitudes, calculating an average (`AVG`). This **aggregation** is central to how Tableau works, and can be confusing at first.

You can change the **aggregate** measure used for any chart by clicking on the little downward-pointing triangle that appears when you hover over the variable:

![](./img/class4_8.jpg)


If you don't want to draw a chart or map that is based on an **aggregation** of *all* of the data, you need to tell Tableau the level of `Detail` for your analysis. Here, we want to draw a single point for each collision. To do that, drag `Caseid`, which is the unique identifying code for each collision, into the `Detail` shelf. Tableau will still try to calculate average locations, but because we have told it to draw a separate point for each `Caseid` in the data, that will be an average of a single `Latitude` and single `Longitude` value for each record in the data.

The map should now look like this:

![](./img/class4_9.jpg)

There should now be two clusters of points, one lying just off the coast of West Africa. Hover over these points, and notice that these have latitudes and longitudes of zero. These are collisions that were not geocoded in the data; but rather than being given a null value, they have a zero.

We will ignore them, and zoom in on Richmond. Hover over the top left of the map, and select the area zoom control:

![](./img/class4_10.jpg)

Use the controls until the map is zoomed in on central Richmond:

![](./img/class4_11.jpg)

Tableau's default basemap is very stripped down, but we can add more features. Select `Map>Map Layers` from the top menu, and check `Streets and Highways`. Close the `Map Layers` panel by clicking the `x` symbol.

The map should now look like this:

![](./img/class4_12.jpg)


#### Color the collisions to show whether or not alcohol was involved

To do this, drag `Alcohol involved` from the `Data` panel onto the `Color` shelf.

The map should now look like this, with collisions that involved alcohol shown in orange:

![](./img/class4_13.jpg)

Some of the points lie over the top of one another. Some transparency will make overlapping circles easier to see. Click on the `Color` shelf and edit the 	`Transparency` to `50%`. Also select a gray `Border`:

![](./img/class4_14.jpg)

To display the orange circles over the top of the blue circles we need to **sort** the legend. Click on the downward-pointing triangle that appears when you hover over the `Alcohol involved` legend, and select `Sort...`. Then fill the dialog box in as follows, moving `Y` above `N`:

![](./img/class4_15.jpg)

#### Scale the collisions by the number of people killed and injured in each

Drag `Killed and injured` from the `Data` panel onto the `Size` shelf. The map should now look like this, with collisions in which more people were killed and injured represented by larger circles:

![](./img/class4_16.jpg)


#### Edit the tooltips

Hover over one of the points on the map, and see that the tooltip displays values for each of the variables we have added to the map so far. The most useful *additional* information to provide in a tooltip, not evident at first glance, is the date of each collision, and a breakdown of the numbers killed and injured, so drag `Date`, `Injured` and `Killed` to the `Tooltip` shelf. Click on `Tooltip` and edit at the dialog box to remove the other variables. Also uncheck `Include command buttons`. This turns off some additional Tableau tooltip functionality, giving a plain tooltip:

![](./img/class4_17.jpg)

#### Set up a filter to map the collisions by year

Now we a control to **filter** the data by year. Tableau's default behavior is to redraw a map or chart each time it is filtered. In this case, the map will redraw to center on the collisions in any given year, and the circles will all rescale to reflect the range of values in the **filtered** data.

If we do not want that to happen, we need to freeze the map, and the size of the circles.

To freeze the map, make sure the pin icon is facing downwards:

![](./img/class4_18.jpg)

If it is not, click on it to freeze the map.

To freeze the size of the circles, hover over the title bar for the size legend, select `Edit sizes...` and fill in the dialog box as follows:

![](./img/class4_19.jpg)

Now we can set up a **filter** by year. `Year` is among the variables in the dataset, but we will instead drag `Date` onto the `Filters` shelf to demonstrate Tableau's flexibility in working with dates and times. At this dialog box, select `Years` and click `Next >`:


![](./img/class4_20.jpg)

At the next dialog box, select `All` and click `OK`:


![](./img/class4_21.jpg)

The map will not change until we set up a control for the filter. Hover over `YEAR(Date)` in the `Filters` shelf, call up its dropdown menu, and select `Show filter`. A filter control with checkboxes will appear at the right:

![](./img/class4_22.jpg)

To change the filter control type, call up the dropdown menu for the filter and select `Single value (slider)`:

![](./img/class4_23.jpg)

Now we have a slider control allowing all of the data to be shown at once, or one year's data at a time:

![](./img/class4_24.jpg)


#### Save to the cloud

Right-click on `Sheet 1`, select `Rename Sheet`, and call it `Map`.

Having finished the map, now is a good time to save our work. From the top menu, select `File>Save To Tableau`. At the log-on dialog box enter your Tableau Public account details, give the Wookbook a suitable name and click `Save`.

When the save is complete, a webpage hosting your map will open in your default browser.

#### Make a column chart showing the number of people killed and injured by year

From the top menu, select `Worksheet>New Worksheet`. Drag `Date` onto `Columns`. As a default, Tableau should select `YEAR(date)`, which is what we require here. You can call up the dropdown menu for the variable to see the other available options:

![](./img/class4_25.jpg)

Now drag `Killed and injured` onto `Rows`. Notice that the default **aggregation** here is `SUM`: Tableau is adding up the numbers of people killed and injured in each year, which is what we want. So this time, we do not need to drag anything onto the `Detail` shelf to change the level of analysis. (Again, if required, we could change the aggregate measure if necessary.)

By default, Tableau has drawn a line chart. So open `Show Me` and select the `Horizontal Bars` option. Now click the `Swap` axes icon:

![](./img/class4_26.jpg)

This should flip the chart from horizontal bars to vertical columns:

![](./img/class4_27.jpg)

#### Color the chart by whether or not alcohol was involved

Drag `Alcohol involved` onto the `Color` shelf, and then edit the transparency to 50% and add a gray border as before. Right-click on the word `Date` at the top of the chart and select `Hide field names for columns` to remove it.

Rename the worksheet as `Column chart - years`, and the screen should look like this:

![](./img/class4_28.jpg)

It shows the data from our Week 3 pivot table in graphical form. Now is a good time to save to the cloud once more.


#### Next steps

This map and chart provide a springboard for more reporting and analysis.

- You could browse the map to look for accident hotspots, especially those that involve alcohol, and use that as the starting point for local reporting.

- You could identify the accidents that caused the most deaths and injuries, and use the California Public Records Act to obtain police reports for these.

- As for the pivot table, the chart raises some questions: Why did was the number of deaths and injuries so high in 2005, compared to all the other years? And why were there so few alcohol-related deaths and injuries in 2010?

- Try altering the **aggregation** for `Date` in the column chart to look at deaths and injuries by month, or by day of the week.

- Try asking different questions of the data. Experiment with different chart types, exploring other variables and **filtering** and **aggregating** the data in different ways, to expose other potential stories in the data.


#### Combine the worksheets into a dashboard and publish on the web

Although our main goal was to explore this data to help direct further reporting, we can also combine the charts into a dashboard to publish on the web.

From the top menu, select `Dashboard>New Dashboard`. We can set the size of the dashboard to fit the web page on which we want to embed it, and this can be a `Range`, giving some basic responsive design. To see how this works, change the `Max` width (w) to `750` pixels.

Drag `Map` into the dashboard. The default title isn't very informative, so right-click on that and select `Hide Title`.

When adding sheets to the dashboard, You can make them `Tiled` or `Floating`, which allows new items to be placed over one another. Here we will stick with the `Tiled` option. Drag `Column chart - years` to the lower half of the map. Drop it when you see a gray rectangle in this position.

Notice that Tableau allows you to drop various other items into a dashboard: horizontal and vertical containers, text boxes, images (which can be good for adding logos), web pages, and blank space.

From the top menu select `Dashboard>Show Title`, replace `<Sheet Name>` with an appropriate title/subtitle and adjust the alignment, fonts, and styles as desired. Rename the dashboard as `Richmond traffic accidents`.

Now add a `Text` box at the bottom of the dashboard, and add the source information:

![](./img/class4_29.jpg)

Finally, call up the dropdown menu for the slider control, select `Edit title...` and change `Year of Date` to `Year`.

The finished dashboard should look something like this:

![](./img/class4_30.jpg)

Save to the cloud as before. When the dashboard opens in your browser, click `Share` to get an `Embed Code`:

![](./img/class4_31.jpg)

Copy this code and paste into into the html of any web page in which you want the dashboard to appear.

Even when publishing single charts, drop them into a dashboard and get the embed code for that, rather than publishing individual worksheets, otherwise they may not display properly online.

### Make a map showing gentrification, urban displacement, and exclusion in the Bay Area

We are going to make a version of [this map](http://www.urbandisplacement.org/map/sf), showing low-income census tracts at various stages of gentrification, and moderate- to high-income census tracts with various degrees of exclusion for low-income households.

Tableau can readily make filled maps like this for the geographic boundaries it recognizes, which include countries, states, counties, and zip codes. Tableau doesn't recognize census tracts, but with Google Fusion Tables you can easily make maps using any geographic boundaries.


#### Connect Google Drive to the Fusion Tables app

If you have not used Fusion Tables before, you will need to connect the app to your Google Drive. Login to your Google account, then navigate to [Google Drive](https://drive.google.com/). Click on the red `NEW` button at top left, and review your options:

![](img/class4_32.jpg)

If you do not see the option to create a new Fusion Table, select `+ Connect more apps` and select Google Fusion Tables:

![](img/class4_33.jpg)

At the next dialog box, click the blue `+ Connect` button at top right. Click `OK` to finish and close the open window.


#### Questions to ask of this data

Our map will ask these questions:

- Which low-income census tracts in the Bay Area are experiencing the highest levels of gentrification, and displacement of low-income households, and which are at risk?
 
- Which moderate- to high- income census tracts in the Bay Area have the highest levels of exclusion for low-income households?

#### Prepare the data

Upload the file `urban_displacement.xlsx` to Google Sheets. The first sheet contains documentation describing the variables in the data.

The second contains the data:

![](img/class4_34.jpg)

Each row in the data represents a separate census tract, which has a unique `tract_id`.

To make a map from this data, we need a Fusion Table that contains geographic data defining the boundaries

Geographic data comes in various formats, two of the most common being [Shapefiles](http://en.wikipedia.org/wiki/Shapefile) and [KML](https://developers.google.com/kml/). KML is the data format used by Google Maps and Google Earth, and can be uploaded directly to Fusion Tables.

Shapefiles are a format used in Geographic Information Systems (GIS) software. They are usually made available for download as zipped folders, and actually consist of a series of files. At a minimum, a shapefile must contain three component files, with the same root name and the following extensions:

- `.shp` The main file containing the geometry of the points, lines or polygons mapped in the shapefile.
- `.dbf` A database file in [dBASE](http://www.dbase.com/) format containing a table of data relating to the components of the geometry. For example, in a world shapefile giving national boundaries, this table might contain data about the countries including their names, capital cities, population, and so on.
- `.shx` A positional index of the shapefile’s geometry.

If the boundary data you need is available only in shapefile format, you can upload to Fusion Tables using the [Shape Escape](http://www.shpescape.com/ft/) website. For this to work, your shapefile must include a `.prj` file, defining the [map projection](https://en.wikipedia.org/wiki/Map_projection) of the file. Zip the folder and follow the directions at Shape Escape. Unless you want to create a point in the center of each area, or simplify the shape of the boundaries, leave the `Advanced Options` unchecked.

![](img/class4_35.jpg)

Uploading a shapefile to Fusion Tables using Shape Escape, which will convert it to KML,  will take some time. This is not something you want to do on a tight deadline!

In this case, I have already uploaded a shapefile of census tracts in California, obtained from the [U.S. Census Bureau](http://www.census.gov/geo/maps-data/data/tiger-line.html). It is [here](https://fusiontables.google.com/DataSource?docid=16rmvHbxu0HR6eYX4XtVZFwQOKoJkj_onJ1f3sNb1#rows:id=1), and the data looks like this:

![](img/class4_36.jpg)

The is a variable called `GEOID`, which contains the same codes as in the `tract_id` vairable in the urban displacement data, with one important difference: Here they are all proceded by a `0`.

We need to **join** the urban displacement data to the census tracts map, but to do that, we need to make the entries for the two variables match properly.

So return to the urban displacement spreadsheet, select the `tract_id` column by clicking on the letter `A`, right-click and select `Insert 1 left`. Call the new column `geoid` and then type the following formula into the first cell:

```SQL
=CONCATENATE("0",B2)
```

The `CONCATENATE` spreadsheet function appends text entries, separated by commas, to one another. Although it should work without the quote marks, it is good practice to use them for any entries that are not other spreadsheet cells, as this defines the entry as text.

![](img/class4_37.jpg)

Now fill the formula down the entire column by hovering over the bottom-right corner of the first cell and double-clicking when the `+` symbol appears.

Having done this, return to your Google Drive home page and select `NEW>More>Google Fusion Tables`. The next dialog box allows you to upload a file from your computer, or a import a Google spreadsheet, which is what we want to do:

![](img/class4_38.jpg)

At the next dialog box, double-click on the urban displacement spreadsheet to select it:

![](img/class4_39.jpg)

The data may take a little time to load. When it does, select the `urban_displacement.xlsx-data` tab, to import the data sheet, rather than the documentation. Don't worry if the data doesn't display correctly in this preview:

![](img/class4_40.jpg)

Click `Next >>`, and repeat at the next screen, then give the table an appropriate name and attribution:

![](img/class4_41.jpg)


Click `Finish` and the new Fusion Table should load:


![](img/class4_42.jpg)

Fusion Tables will highlight in yellow any geographic entities it recognizes, and can add them as points to a map. However, we do not want to use that option in this case.

#### Join the urban displacement data to the census tracts map

So far we have repeatedly **sorted**, **filtered**, and **aggregated** data. Now we are going to perform a **join** -- the last of the four common operations we discussed in Week 1.

Fusion Tables calls this a "merge." Select `File>Merge...` from the menu in the urban displacement Fusion Table. At the dialog box, paste the [**url**](https://fusiontables.google.com/DataSource?docid=16rmvHbxu0HR6eYX4XtVZFwQOKoJkj_onJ1f3sNb1#rows:id=1) for my California census tracts Fusion Table into the web address box at the bottom, and click `Next`:

![](img/class4_43.jpg)

Fusion Tables should recognize that there are matching variable names in the two tables. If it does not, you can use the dropdown menus to select the correct variables. Then click `Next`:

![](img/class4_44.jpg)

The next dialog box allows you to choose which variables to include in the new table. Those from the table you are joining to are shown with a subtle yellow background. You *must* include `geometry` if you want to be able to make a map.

![](img/class4_45.jpg)

We will retain all the variables, so just click `Merge`, and then `View table`. You can edit its title by clicking on it:

![](img/class4_46.jpg)

#### Style the map to show the degree of gentrification or exclusion in each census tract


We want to make a map highlighting the degree of exclusion or displacement/gentrification. There are text descriptions of these categories in the variable `disp_descr`, and numerical codes for the categories in the variable `disp_type`. This is how they correspond:

| disp_type | disp_descr |
|--------|--------|
|1   	  |LI - Not losing LI households or very early stages of displacement|
|2        |LI - At risk of gentrification or displacement|
|3        |LI - Undergoing displacement|
|4        |LI - Advanced gentrification|
|5        |MHI - Not losing LI households or very early stages of displacement|
|6        |MHI - At risk of displacement|
|7        |MHI - Undergoing displacement|
|8        |MHI - Advanced exclusion|

To make a filled map in Fusion Tables, we need to use a numeric column, so we will use `disp_type`.

Click on the `Map of geometry` tab and zoom into the Bay Area. You should see a map like this:

![](img/class4_47.jpg)

To color the map, click `Change feature styles...`, and at the dialog box select `Fill color` on the left and the `Buckets` tab. Divide into `8` buckets, and select the column `disp_type`:

![](img/class4_48.jpg)

Now we need to set the number range and color for each bucket. Choose ranges that will encompass the numbers in the `disp_type` codes (for example `0.5` to `1.5`, `1.5` to `2.5`, and so on). Pick pick two distinct color themes for the `LI` and `MHI` tracts, and use increasing intensity of those colors to represent the increasing degrees of gentrification or exclusion. Also adjust the opacity of each fill to `75%`:

![](img/class4_49.jpg)

Click `Save` and the map should now look like this:

![](img/class4_50.jpg)

#### Customize the pop-ups

Click on one of the census tracts and notice that a information window pops up, showing the data for variables in the table.

![](img/class4_51.jpg)

Click `Change info window ...` and select the variables you would like to show:

![](img/class4_52.jpg)

Now select the `Custom` tab and edit the labels in the HTML code that appears:

![](img/class4_53.jpg)

Click `Save`, and then click on one of the tracts again to view the result:

![](img/class4_54.jpg)


#### Next steps

Again, this map provides a starting for more reporting and analysis.

- You can now clearly identify low-income census tracts with different levels of gentrification, and moderate- to high-income tracts with different levels of exclusion, to direct local reporting into these issues.
- There are many other variables in the data that you can map, if you are interested in particular aspects of gentrification and exclusion.

To make a new map, click the `+` symbol at the right of the tabs at the top and `Add map`:

![](img/class4_55.jpg)

#### Embed this map on any web page

Before you can embed the map on a website, you need to make it visible to the wider world by clicking the `Share` button at top right. At the dialog box click on the `Change...` link, select `Public on the web` and click `Save` and then `Done`.

To embed this map on a web page, select `Tools>Publish` from the top menu. Here you can select the `Width` and `Height` in pixels for your map. You can then extract the iframe code that appears under `Paste HTML to embed in a website` to embed on any web page.

![](img/Class4_56.jpg)

If you change the width in the iframe code to `100%`, rather than giving a value in pixels, it will automatically adjust to the width of the page in which it is placed.

To put the map onto its own page, paste the code that appears in the box under `Get HTML and JavaScript` into a blank file in a text editor. Save this file with the extension `html`.


### Assignment



### Further reading/viewing

[Tableau Public training videos](http://www.tableausoftware.com/public/training)

[Gallery of Tableau Public visualizations](http://www.tableausoftware.com/public/gallery/all): You can download any of these examples using the links at bottom right and open the files (which will have the extension `.twbx`) with Tableau Public to see how they were put together.

[Tableau Knowledge Base](http://kb.tableau.com/): Useful resource with the answers to many queries about how to use the software.

[Google Fusion Tables documentation](https://support.google.com/fusiontables/answer/2571232?hl=en)

















