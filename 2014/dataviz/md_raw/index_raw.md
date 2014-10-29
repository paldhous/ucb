
# Introduction to Data Visualization, Fall 2014

This is a course in finding and telling visual stories from data. We will cover fundamental principles of data analysis and visual presentation, chart types and when to use them, and how to acquire, process and “interview” data. We will make static and interactive charts and maps using free software. There will be some coding, but no prior experience is required. The emphasis is on gaining practical skills that students can apply in a newsroom setting.

### Weekly schedule

We will meet in **108/Lower NG** on Tuesdays from 10.00am - 1.00pm. Your instructor, [**Peter Aldhous**](http://www.peteraldhous.com/), will maintain office hours in **B1** from 2.00pm - 5.00pm, following each class. You are welcome to arrange appointments to discuss your work.

Where marked, class time will be scheduled for one of you to critique and lead discussion of a recently published news graphic/interactive.

 - ####**Sept. 2:**	[**What is data?**](week1.html)
Categorical and continuous variables; basic operations for interviewing a dataset; sampling and margins of error; plotting and summarizing distributions; choosing bins for your data; basic newsroom math; correlation and its pitfalls; exploring differences between groups; scatter plots and box plots.

  - **Assignment:** make scatter plots and box plots using [ggplot2 web app](http://rweb.stat.ucla.edu/ggplot2/); subscribe to data viz blogs etc to follow latest developments in visualization.

- ####**Sept. 9:** 	[**Data visualization: basic principles**](week2.html)
Encoding data using visual cues; choosing chart types to show comparisons, composition (parts of the whole) and connections; using color effectively; using chart furniture, minimizing chart junk and highlighting the story; avoiding pitfalls; good practice, including for interactive graphics.

 - **Assignment:** quiz on good practice in visualization and data analysis.


- ####**Sept. 16:** [**Interviewing data: exploratory graphical analysis**](week3.html)
We will use [Tableau Public](http://www.tableausoftware.com/public/) to explore and visualize data including traffic accidents in Berkeley, combining a map and charts into an interactive online dashboard.

 - Student-led critique
 - **Assignment:** make a second dashboard for the traffic accident data; suggest other data that could improve the analysis.


-  ####**Sept. 23:**	[**Interviewing data: using databases**](week4.html)
Introduction to databases and Structured Query Language for manipulating data, prior to visualization. We will use [SQLite](http://sqlite.org/) and the [SQLite Manager](https://addons.mozilla.org/en-US/firefox/addon/sqlite-manager/) Firefox plugin to explore data including drug company payments to doctors. We will also make pivot tables in [Libre Office Calc](http://www.libreoffice.org/discover/calc/).

 - Student-led critique
 - **Assignment:** write queries to return specified data. 


- ####**Sept. 30:**	[**Acquiring, cleaning and formatting data**](week5.html)
Data search and download tricks, including [Table2Clipboard](https://addons.mozilla.org/en-US/firefox/addon/dafizilla-table2clipboard/) and [DownThemAll!](https://addons.mozilla.org/en-US/firefox/addon/downthemall/) Firefox plugins; manipulating urls and using APIs to acquire data; scraping data from the web with [Import.io](https://import.io/); cleaning data with [Open Refine](http://openrefine.org/); converting data between different formats using [Mr. Data Converter](http://shancarter.github.io/mr-data-converter/).

 - Student-led critique
 - **Assignment:** data cleaning task with Open Refine.


-  ####**Oct. 7:**	[**Making static graphics**](week6.html)
Introduction to [R](http://www.r-project.org/), [R Studio](http://www.rstudio.com/) and R packages including [ggplot2](http://ggplot2.org/) for visualization; the grammar of graphics; manipulating data with R. We will visualize data including measures of the wealth and wellbeing of nations, exporting charts in vector image formats.

 -  Student-led critique
 -  **Assignment:** make specified graphics with ggplot2.


- ####**Oct. 14:**	[**Polishing static graphics**](week7.html)
Further work with R/R Studio, as necessary. We will then use [Inkscape](http://www.inkscape.org/en/) to edit, refine and annotate charts exported from R.

 - Student-led critique
 - **Assignment:** use Inkscape to refine a ggplot2 graphic to publication standard.


- ####**Oct. 21:**	[**Principles of mapping; introduction to final projects**](week8.html)
Basic mapping principles:  projections, geocoding, geodata formats; approaches to putting data onto maps, including choropleth maps, scaled symbols, hexagonal binning and cartograms. We will also discuss the data made available for your final projects; students may add further data, or suggest entirely different datasets, with the instructor’s approval.

 - Student-led critique
 - **Assignment:** start exploring data for your final project; make some initial sketches.


-  ####**Oct. 28:**	[**Making static maps and processing geodata**](week9.html)
We will use [QGIS](http://qgis.org/en/site/) to make a multi-layered map from data on seismic hazards and historical earthquakes. We will also learn how to use QGIS and its plugins to process geodata, including converting between formats, simplifying data, joining maps to external data and hexagonal binning of points.

 - Student-led critique
 - **Assignment:** make a simple choropleth map requiring a data join.


-  ####**Nov. 4:**	**No class**
Instead, one-on-one meetings will be arranged with instructor to discuss your final projects.

 - **Assignment:** refine plan for your final project.


- ####**Nov. 11:**	[**Making interactive maps**](week11.html)
We will use [TileMill](https://www.mapbox.com/tilemill/), [Leaflet](http://leafletjs.com/) and some simple JavaScript to create an interactive online version of the earthquake and seismic hazard map. This will include an API call so that the map automatically updates to include new quakes.

 - Student-led critique
 - **Assignment:** deliver your finished online map; continue work on final project.


- ####**Nov. 18:**	[**Visualizing networks**](week12.html)
Basic principles of network visualization and analysis; we will then use [Gephi](https://gephi.github.io/) to create network graphs illustrating voting patterns in the U.S. Senate.

 - Student-led critique
 - **Assignment:** deliver your finished network visualizations; continue work on final project. 


- ####**Nov. 25:**	[**Coding interactive graphics**](week13.html)
We will use [D3](http://d3js.org/) to code from scratch an online interactive visualization of the gender pay gap across occupations. This will be a challenging exercise, intended as an introduction to the huge possibilities offered by a JavaScript code library that powers many of today’s most impressive online news visualizations.

 - Student-led critique
 - **Assignment:** continue work on your final project.


- ####**Dec. 2:**	**Guest Speaker: [Arvind Satyanarayan](http://arvindsatya.com/)**
Arvind will present his tool [Lyra](http://idl.cs.washington.edu/projects/lyra/), a visualization design environment developed to unleash the expressivity of D3 without the need to code from scratch. He will lead you through visualization exercises including the emulation of published graphics from *The New York Times*.

 - Student-led critique 
 - **Assignment:** complete your final project. During this week, we will also schedule a second series of one-on-one meetings with the instructor to refine your final projects, which are due on the last day of class.


- ####**Dec. 9:**	**Coding interactive graphics continued; wrapping up**
We will continue work on the D3 visualization, as necessary, and conclude with a discussion of lessons learned, and next steps to continue to develop your data manipulation and visualization skills.

 - Student-led critique

### Recommended reading

Alberto Cairo: [*The Functional Art: An Introduction to Information Graphics and Visualization*](http://www.amazon.com/The-Functional-Art-introduction-visualization/dp/0321834739/)
Nathan Yau: [*Data Points: Visualization That Means Something*](http://www.amazon.com/Data-Points-Visualization-Means-Something/dp/111846219X)

Further reading/viewing will be recommended to support weekly class material.

### Attendance

Unexcused absence from two classes will drop you one letter grade; a third unexcused absence will result in an F. Excused absences will be permitted only in extraordinary circumstances. Regardless of the reason for an absence, students will be responsible for any assignments due and for learning material covered in class. 

### Grading

Class participation, weekly assignments: **45%**
Final project: **45%**
Attendance:	**10%**

### Good manners

Students must turn off the ringers on their cell phones before class begins. Students may not check e-mail, social media sites or other websites during lecture portions of class or while working on class exercises.

### Academic dishonesty and plagiarism

The high academic standard at the University of California, Berkeley, is reflected in each degree that is awarded. As a result, it is up to every student to maintain this high standard by ensuring that all academic work reflects his/her own ideas or properly attributes the ideas to the original sources.

These are some basic expectations of students with regards to academic integrity:

- Any work submitted should be your own individual thoughts, and should not have been submitted for credit in another course unless you have prior written permission to re-use it in this course from this instructor.

- All assignments must use “proper attribution,” meaning that you have identified the original source of words or ideas that you reproduce or use in your assignment. This includes drafts and homework assignments!

- If you are unclear about expectations, ask your instructor.

### Disability accommodations

If you need disability-related accommodations in this class, if you have emergency medical information you wish to share with the instructor, or if you need special arrangements in case the building must be evacuated, please inform the instructor as soon as possible by seeing him after class or making an appointment to visit during office hours. If you are not currently listed with DSP (Disabled Students’ Program) but believe that you could benefit from their support, you may [apply online](http://dsp.berkeley.edu/).





