# Software and other tools

To install some of the software below, you will need to alter your Mac security preferences to allow apps authored by developers that are not part of Apple's ecosystem. Open `System Preferences>Security & Privacy`, select the `General` tab and click the lock icon at bottom left to make changes, then allow apps downloaded from `Anywhere`:

![](./img/software_1.jpg)

### [Firefox](https://www.mozilla.org/en-US/firefox/new/)

Some of the tools we will use are Firefox add-ons. Ensure that you have the latest version of this popular web browser. [Download Firefox](https://www.mozilla.org/en-US/firefox/all/), or if already installed, if necessary update to the latest version [following these instructions](https://support.mozilla.org/en-US/kb/update-firefox-latest-version).

### [Sublime Text](http://www.sublimetext.com/) or [TextWrangler](http://www.barebones.com/products/textwrangler/)

For some exercises, you will need a text editor optimized for authoring web pages. These are both good options.

### [ggplot2 web app](http://rweb.stat.ucla.edu/ggplot2/)

Allows you to create charts through a point-and-click interface, unlocking the basic functionality of ggplot2, a visualization package for R (see below). Web app: no installation required.

### [ColorBrewer](http://colorbrewer2.org/)
Your go-to resource for color schemes to encode data. Web app: no installation required.

### [Color Oracle](http://colororacle.org/)
Allows you to simulate the effects of three forms of colorblindness on your screen, to check that your charts and maps do not exclude the color-impaired. [Download](http://colororacle.org/index.html) and move to your Applications folder. When launched, program icon will appear to the right of your menu bar. You can set to start at login under `Preferences`.

### [Tableau Public](http://www.tableausoftware.com/public/)
Visualization software designed for exploratory graphic analysis, which also allows you to create interactive online graphics without JavaScript coding. [Download here](http://www.tableausoftware.com/public/download). You will also need to [sign up](https://public.tableausoftware.com/auth/signup) for a free Tableau Public account.

The Public version of the software requires you to save your visualizations to the open web. However, members of Investigative Reporters and Editors can obtain a [license for the Professional version](https://www.ire.org/blog/ire-news/2013/06/20/tableau-makes-its-desktop-software-free-ire-member/), which allows you to save workbooks on your machine. In any case, I strongly recommend that J-School students [join IRE](http://www.ire.org/membership/apply/) as a student member: it is a leader for training in data journalism.

### [GitHub Desktop](https://desktop.github.com/)

Point-and-click GUI for version control of your projects, and synching with remote hosting at [GitHub](https://github.com/). Download from [here](https://desktop.github.com/). You will also need to sign up [here](https://github.com/) for a free GitHub account.

### [Haroopad](http://pad.haroopress.com/)

[Markdown](https://en.wikipedia.org/wiki/Markdown) editor, which will make authoring webpages much easier. Download from [here](http://pad.haroopress.com/user.html). (If you are already using Markdown, feel free to keep using the editor of your choice.)

### [Table2Clipboard](https://addons.mozilla.org/en-US/firefox/addon/dafizilla-table2clipboard/) and [DownThemAll!](https://addons.mozilla.org/en-US/firefox/addon/downthemall/)
Two handy Firefox add-ons, which will help you extract data from the web. Install them in Firefox [here](https://addons.mozilla.org/en-US/firefox/addon/dafizilla-table2clipboard/) and [here](https://addons.mozilla.org/en-US/firefox/addon/downthemall/).

### [Import.io](https://import.io/)
A tool for scraping data from the web, without the need to write code. You will need to sign up for an account at the `Sign up` link on the home page, and download the app from [here](https://www.import.io/download/download-no-longer-supported/). (Import.io is still in the progress of migrating from a Desktop app to a web-only application.)

### [Open Refine](http://openrefine.org/)
A powerful tool for data cleaning, once owned by Google, now open source. Download the latest **stable version** [from here](http://openrefine.org/download.html). When launched, Open Refine will work in your default web browser; note that your data remains on your computer, and is not uploaded to the web.

### [Mr. Data Converter](http://shancarter.github.io/mr-data-converter/)
Allows you to convert tabular (spreadsheet/CSV) data to web-friendly formats including JSON. Web app: no installation required.


### [GPS Visualizer batch geocoder](http://www.gpsvisualizer.com/geocoder/)
Allows you to convert addresses to latitude and longitude coordinates. Web app: no installation required; however, you will need to sign up for API keys for the geocoding services it uses.

### [CARTO](https://cartodb.com)
A sophisticated cloud-based mapping application that also functions as a geospatial database, allowing you to analyze and process geodata. [Sign up](https://cartodb.com/signup) here for a free account.


### [QGIS](http://qgis.org/en/site/)
The leading open source Geographic Information System, which we will use to make maps and process geodata. Download the latest **standard** version of QGIS and its requirements [from here](http://www.kyngchaos.com/software/qgis/). Install GDAL and the Matplotlib Python module before installing QGIS itself.

### [R](http://www.r-project.org/) and [R Studio](http://www.rstudio.com/)
R is a software environment and programming language for statistical computing and graphics. Download the for OSX from [here](https://cran.rstudio.com/). R Studio provides a user interface that makes it much easier to use. Download the latest free version of RStudio Desktop [from here](http://www.rstudio.com/products/rstudio/download/).

### [ImageMagick](http://imagemagick.org/script/index.php) and [FFmpeg](http://ffmpeg.org/)

ImageMagick is a software library for creating, editing, converting and manipulating images, including animated GIFs. FFmpeg is a software library that records and converts audio and video.

We will use them in conjunction with R to make animated graphics. They take some time to install, so it is important that you do this before class.

Here are the steps for installation:

 - Download and install **Xcode**. 
  - If you have Mac OS 10.11 El Capitan, you should be able to download and install [from the App Store](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). 
  - If you have Mac OS 10.10 Yosemite, first sign up as an Apple Developer, [here](https://developer.apple.com/programs/enroll/). Then go [here](https://developer.apple.com/download/more/), and download and install **Xcode 7.2.1**. Later versions will not work.
  - If you are unsure which version of the operating system you have, click the Apple symbol at the left of the top menu and select `About this Mac`.
  - You may need to launch **Xcode**  and agree to the terms of service.

 - Open a Terminal window (find under `Applications>Utilities`) and enter:
 ```R
xcode-select --install
 ```
 This will install Xcode's command line tools, which are required for [**MacPorts**](https://www.macports.org/), the installer we will use to install the two software libraries.
 - [Download and install](https://www.macports.org/install.php) the correct version of MacPorts for your Mac OS.

 - In the Terminal, enter: 
 ```R
 sudo port install ImageMagick
 ```
 You will be required to enter your Mac password. The installation will take some time to complete. This is a good time to make a cup of coffee.
 - When ImageMagick has installed, repeat the process for FFmpeg:
  ```R
 sudo port install ffmpeg
 ```






