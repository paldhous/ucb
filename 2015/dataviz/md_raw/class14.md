# Let's apply what we've learned

Your task for this week's class is to create a version of the interactive graphic below, showing carbon dioxide emissions, by world region, from 2000 to 2011. We will do this in R, which will require you to adapt the code we used in the previou weeks to process the data and turn it into an NVD3 chart.

##### Carbon dioxide emissions, in gigatonnes, by world region


### How to proceed

- Download [this folder](data/week14.zip) to your desktop and unzip. It contains the JavaScript and CSS files necessary to draw an NVD3 chart.

- Use the WDI package to obtain the [data](http://data.worldbank.org/indicator/EN.ATM.CO2E.KT) from the World Bank's World Development Indicators site. Download the data for all countries in the first instance. The indicator name is `EN.ATM.CO2E.KT`.

- Then filter the data, using the dplyr package, for the seven World Bank regions. Use the `iso2c` codes to do this. The relevant codes for the regions are: `Z4`, `Z7`, `ZJ`, `ZQ`, `XU`, `8S`, and `ZG`. You will find a code example of filtering with dplyr in the previous week's class notes.

- Create a new column in the data, using the `mutate` dplyr function, called `co2`, containing the carbon dioxide emission values divided by a million, and rounded to two decimal places. This will give the emission values in gigatonnes, formatted to display conveniently on the chart Y axis. You will need to use R's `round` function; again, you can find code examples in the previous week's class notes.

- Make an NVD3 chart from the processed data, using the rCharts package. The chart type will be `stackedAreaChart`.

- Save the chart, as we did in the previous week's class, to the folder you downloaded above.

- Open the saved HTML file in your text editor, then swap out the existing links to JavaScript and CSS resources for the following:
- ```CSS
  <link rel="stylesheet" href="css/nv.d3.css">
  <script src="src/d3.min.js"></script>
  <script src="src/nv.d3.min.js"></script>
  <script src="src/jquery-1.11.3.min.js"></script>
```
- Still in your text editor, change the width of the chart to `100%`, for a responsive design, and comment out the second mention of a default width of `800px`.

- Advanced: You will notice that some of your chart labels contain the phrase `(all income levels)`. See if you can go back to the R code and figure out how to remove these.


