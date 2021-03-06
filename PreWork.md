# Pre-Work for Visualization for Data Science in R

Welcome to "Visualization in Data Science using R," a two-day course on using R for visualization. 

## Prerequisites

This course assumes basic familiarity with R — e.g., R syntax, data structures, development environments. Participants with no knowledge of R should consider taking an introductory R short course. A significant portion of the course will use ggplot2 and other tidyverse packages to create visualizations, but prior experience with those packages is not required. 

## Installations

In order to participate in class exercises, participants will need a computer where you have installed current versions of [R](https://www.r-project.org/), [RStudio](https://www.rstudio.com/), and the following packages: 

* tidyverse (which includes ggplot2)
* knitr
* shiny
* plotly
* DT
* crosstalk
* flexdashboard
* maps
* mapproj
* sf

Having appropriate user permissions to install packages on the fly would be useful. 

(Note: Mac users without Xcode already installed may see a prompt to install Xcode or the "command line tools" to compile some packages from source. You should go ahead and do that -- at least the command line tools. This is often a large installation, though, so it may take a bit of time.)


## Course Logistics

I will be sharing datasets and code using [GitHub](https://github.com/), but you will not have to have a GitHub account or a git installation on your laptop to participate in the course. It will be easy to download the files from the GitHub website and open them in RStudio.

For this course I will be using [RMarkdown](https://rmarkdown.rstudio.com/) files rather than simple R scripts. RMarkdown is a way of interweaving R code with other kinds of descriptive content -- text, links, images. When you only use R scripts in RStudio, the plots show up in the plot window, which only shows one plot at a time. RMarkdown allows us to create separate code "chunks" for different plots, and each plot will appear immediately below its code chunk. 

If you're not familiar with RMarkdown, I will give a brief overview, but you can also [explore it on your own](https://rmarkdown.rstudio.com/lesson-1.html) in advance.

