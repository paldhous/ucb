# Software and other tools

When you try to install some of the software below, you will be warned that it comes from an unknown developer. To override this warning and install the software, right-click and select `Open`.

### [Google Sheets](https://www.google.com/sheets/about/)
Our spreadsheet application for these classes will be Google Sheets. Use from your [Google Drive ](https://drive.google.com/)account.

### [Chrome](https://www.google.com/chrome/)

Some of the tools we will use are Chrome add-ons. Ensure that you have the latest version of this popular web browser.

### [Sublime Text](https://www.sublimetext.com/) or [Brackets](http://brackets.io/)

For some exercises, you will need a text editor optimized for authoring web pages. These are both good options.

### [ColorBrewer](http://colorbrewer2.org/)
Your go-to resource for color schemes to encode data. Web app: no installation required.

### [Color Oracle](https://colororacle.org/)
Allows you to simulate the effects of three forms of colorblindness on your screen, to check that your charts and maps do not exclude the color-impaired. [Download](https://colororacle.org/index.html) and move to your Applications folder. When launched, program icon will appear to the right of your menu bar. You can set to start at login under `Preferences`.

### [Tableau Public](https://public.tableau.com/s/)
Visualization software designed for exploratory graphic analysis, which also allows you to create interactive online graphics without JavaScript coding. You will also need to [sign up](https://public.tableausoftware.com/auth/signup) for a free Tableau Public account.

The Public version of the software requires you to save your visualizations to the open web. However, members of Investigative Reporters and Editors can obtain a [license for the Professional version](https://www.ire.org/blog/ire-news/2013/06/20/tableau-makes-its-desktop-software-free-ire-member/), which allows you to save workbooks on your machine. In any case, I strongly recommend that J-School students [join IRE](https://www.ire.org/membership/apply/) as a student member: it is a leader for training in data journalism.

### [GitHub Desktop](https://desktop.github.com/)

Point-and-click GUI for version control of your projects, and synching with remote hosting at [GitHub](https://github.com/). Download from [here](https://desktop.github.com/). You will also need to sign up [here](https://github.com/) for a free GitHub account.

### [Haroopad](http://pad.haroopress.com/)

[Markdown](https://en.wikipedia.org/wiki/Markdown) editor, which will make authoring webpages much easier. Download from [here](http://pad.haroopress.com/user.html). (If you are already using Markdown, feel free to keep using the editor of your choice.)

### [Open Refine](http://openrefine.org/)
A powerful tool for data cleaning, once owned by Google, now open source. Download the **version 2.8** [from here](http://openrefine.org/download.html). When launched, Open Refine will work in your default web browser; note that your data remains on your computer, and is not uploaded to the web.

### [Mr. Data Converter](https://shancarter.github.io/mr-data-converter/)
Allows you to convert tabular (spreadsheet/CSV) data to web-friendly formats including JSON. Web app: no installation required.

### [GPS Visualizer batch geocoder](http://www.gpsvisualizer.com/geocoder/)
Allows you to convert addresses to latitude and longitude coordinates. Web app: no installation required; however, you will need to sign up for API keys for the geocoding services it uses.

### [QGIS](https://qgis.org/en/site/)
The leading open source Geographic Information System, which we will use to make maps and process geodata. Download version 3.2 from [here](https://qgis.org/en/site/forusers/download.html), and download Python 3.6 from [this link](https://www.python.org/ftp/python/3.6.5/python-3.6.5-macosx10.9.pkg). First install Python 3.6, then install GDAL Complete from the QGIS Download, and finally install QGIS.

### [R](https://www.r-project.org/) and [R Studio](https://www.rstudio.com/)
R is a software environment and programming language for statistical computing and graphics. Download the for OSX from [here](https://cran.rstudio.com/). R Studio provides a user interface that makes it much easier to use. Download the latest free version of RStudio Desktop [from here](https://www.rstudio.com/products/rstudio/download/).

### [ImageMagick](https://imagemagick.org/script/index.php) and [FFmpeg](https://ffmpeg.org/)

ImageMagick is a software library for creating, editing, converting and manipulating images, including animated GIFs. FFmpeg is a software library that records and converts audio and video.

We will use them in conjunction with R to make animated graphics. They take some time to install, so it is important that you do this before class.

Here are the steps for installation:

 - Download and install **Xcode**.
  - If you have Mac OS 10.12 Sierra or Mac OS 10.13 High Sierra, you should be able to download and install [from the App Store](https://itunes.apple.com/us/app/xcode/id497799835?ls=1&mt=12). 
  - If you have older versions of Mac OS, first sign up as an Apple Developer, [here](https://developer.apple.com/programs/enroll/). Then go [here](https://developer.apple.com/download/more/), and download and install **Xcode 7.2.1**.
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






