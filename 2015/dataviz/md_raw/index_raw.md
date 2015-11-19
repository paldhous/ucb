
# Introduction to Data Visualization, Fall 2015

This is a course in finding and telling visual stories from data. We will cover fundamental principles of data analysis and visual presentation, chart types and when to use them, and how to acquire, process and “interview” data. We will make interactive and static charts and maps using free software. There will be some coding, but no prior experience is required. The emphasis is on gaining practical skills that students can apply in a newsroom setting.

### Weekly schedule

We will meet in **106/Upper NG** on Thursdays from 9.30am - 12.30pm. Your instructor, [**Peter Aldhous**](http://www.peteraldhous.com/), will maintain office hours in **B1** from 1.30pm - 5.00pm, following each class. You are encouraged to arrange appointments to discuss your work.

Class time will also be scheduled for each of you to critique and lead class discussion of a recently published news graphic/interactive.

 - ####**Aug. 27:**	[**What is data?**](week1.html)
Categorical and continuous variables; basic operations for interviewing a dataset; sampling and margins of error; plotting and summarizing distributions; choosing bins for your data; basic newsroom math; correlation and its pitfalls; exploring differences between groups; scatter plots and box plots.

  - **Assignment:** make plots using [ggplot2 web app](http://rweb.stat.ucla.edu/ggplot2/); subscribe to data viz blogs etc to follow latest developments in visualization.

- ####**Sept. 3:** 	[**Data visualization: basic principles**](week2.html)
Encoding data using visual cues; choosing chart types to show comparisons, composition (parts of the whole) and connections; using color effectively; using chart furniture, minimizing chart junk and highlighting the story; avoiding pitfalls; good practice, including for interactive graphics.

 - **Assignment:** quiz on good practice in visualization and data analysis.


- ####**Sept. 10:** [**Interviewing data: exploratory graphical analysis**](week3.html)
We will use [Tableau Public](http://www.tableausoftware.com/public/) to explore and visualize World Bank data on neonatal deaths across the globe, creating an interactive online dashboard.

 - **Assignment:** make another dashboard from the same data, and combine into a Tableau story.


-  ####**Sept. 17:** [**Acquiring, cleaning and formatting data**](week4.html)
Data search and download tricks, including [Table2Clipboard](https://addons.mozilla.org/en-US/firefox/addon/dafizilla-table2clipboard/) and [DownThemAll!](https://addons.mozilla.org/en-US/firefox/addon/downthemall/) Firefox plugins; manipulating urls and using APIs to acquire data; scraping data from the web with  [Kimono](https://www.kimonolabs.com/); cleaning data with [Open Refine](http://openrefine.org/); converting data between different formats using [Mr. Data Converter](http://shancarter.github.io/mr-data-converter/).

 - **Assignment:** data cleaning task with Open Refine.


- ####**Sept. 24:** [**Interviewing data: using databases**](week5.html)
Introduction to databases and Structured Query Language for manipulating data. We will use [SQLite](http://sqlite.org/) and the [SQLite Manager](https://addons.mozilla.org/en-US/firefox/addon/sqlite-manager/) Firefox plugin to explore data including drug company payments to doctors.

 - **Assignment:** write queries to return specified data.


- ####**Oct. 1:** [Let's apply what we've learned so far](week6.html)
We will obtain and process World Bank data on life expectancy and GDP per capita for the world's nations from the web, and then create a Tableau visualization inspired by [this Gapminder video](http://www.gapminder.org/videos/200-years-that-changed-the-world-bbc/).

 - **Assignment:** download and process World Bank data on nations' carbon dioxide emissions per capita, and make a simple Tableau dashboard.


-  ####**Oct. 8:**	[**Principles of mapping; introduction to final projects**](week7.html)
Basic mapping principles:  projections, geocoding, geodata formats; approaches to putting data onto maps, including choropleth maps, scaled symbols, hexagonal binning and cartograms. We will also discuss datasets made available for your final projects; you are encouraged, however, to suggest your own.

 - **Assignment:** submit a pitch detailing plans for your final project. You should also each arrange an individual appointments with your instructor over the coming week to discuss your plans.


- ####**Oct. 15:** [**Making static maps and processing geodata with GIS software**](week8.html)
We will use [QGIS](http://qgis.org/en/site/) to make a multi-layered map. We will also learn how to use QGIS and its plugins to process geodata.

 - **Assignment:** make a simple map requiring a data join.


-  ####**Oct. 22:** [**Making interactive maps; processing geodata with SQL**](week9.html)
We will use [CartoDB](https://cartodb.com/) to create interactive online maps. We will also use SQL and [PostGIS](http://postgis.net/), which is built into CartoDB, to process and analyze geodata.

 - **Assignment:** Continue work on final project and deliver a progress report.


-  ####**Oct 29:**	**No Class**
Instead, one-on-one meetings will be arranged with instructor to discuss progress with your final projects.

 - **Assignment:** refine plan for your final project.


- ####**Nov. 5:**	[**Manipulating data and making graphics with R**](week11.html)
Introduction to [R](http://www.r-project.org/), [R Studio](http://www.rstudio.com/) and R packages including [ggplot2](http://ggplot2.org/) for visualization and [dplyr](https://cran.rstudio.com/web/packages/dplyr/vignettes/introduction.html) for data manipulation.

 -  **Assignment:** make specified graphics with ggplot2.


- ####**Nov. 12:** [**Coding interactive graphics**](week12.html)
We will use [D3](http://d3js.org/) to code from scratch a number of common chart types. This will be a challenging exercise, intended as an introduction to the huge possibilities offered by a JavaScript code library that powers many of today’s most impressive online news visualizations.

  -  **Assignment:** continue work on your final project.


- ####**Nov. 19:**	[**Now let's make this easier: from R to interactive charts and maps**](week13.html)
We will explore R packages, including [rCharts](http://rcharts.io/), that allow you to create JavaScript visualizations straight from your data with a minimum of coding.
 
 -  **Assignment:** Continue work on your final project. Each of you should also an individual meetings with your instructor to refine your final projects, which are due on the last day of class.


- ####**Nov 26:** Thanksgiving -- No Class

 - **Assignment:** continue work on your final project.


- ####**Dec. 3:** [Let's apply what we've learned](week14.html)
As in week 6, we will obtain and process data from online, and make some interactive charts, but this time using code.

 - **Assignment:** complete your final project.


- ####**Dec. 10:** [Student presentations on final projects](week15.html)
You will each present your final project work to the class, explain the process of creating the graphics, choices in  analysis and design, and problems that arose and how these were addressed.

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





