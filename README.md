# Advancing pre-university students' computational thinking skills through an educational project based on tangible elements and virtual block-based programming

R Markdown notebook for the paper ["Advancing pre-university students' computational thinking skills through an educational project based on tangible elements and virtual block-based programming"](https://onlinelibrary.wiley.com/journal/10990542)

> Trilles S, Granell C. 
> Advancing pre-university students' computational thinking skills through an educational project based on tangible elements and virtual block-based programming. 
> Submitted to Computer Applications in Engineering Education
> DOI: 


This repository is archived on Zenodo:

> ZENODO DOI TO BE INSERTED HERE

<!--
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3609267.svg)](https://doi.org/10.5281/zenodo.3609267)
-->

## Reproduce Online

Click the "Binder" button below to open the notebook on [binder.org](https://mybinder.org/).

> BIDNER LINK TO BE INSERTED HERE

<!--
[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/cgranell/apps-mental-disorders-jmir/master?urlpath=rstudio)
-->

In the RStudio page, open the file `analysis.Rmd`, the _main analysis file_. Then select "Knit > Knit to HTML" to render the document, which includes the complete analysis workflow, and display it in your browser. 

Alternatively, click on the file  `analysis.html`, the results of the analysis, and select `View in Web Browser` to display it. 

## Reproduce locally

Open the main analysis file `analysis.Rmd` with RStudio. Then select "Knit > Knit to HTML" to render the document. If you have errors rendering it, try running each chunk to locate the problem.

The R Markdown document does not include code to install required packages. Run the code in the file `install.R` to install all dependencies.



## Files in this repository

 - `analysis.Rmd`: R Markdown document with the code to conduct the analysis and create the two figures of the paper.
 - `analysis.html`: HTML rendering of the analysis document.
 - `Dockerfile`: A recipe for the computational environment using [Docker](https://en.wikipedia.org/wiki/Docker_(software)).
 - `install.R`: R script file executed during creation of the Docker image to install required dependencies.

`data` folder: 
 - `datos-practica-UJI.csv`: Data items extracted from each individual course session held from 2017 to 2019 ([csv](https://en.wikipedia.org/wiki/Comma-separated_values) format).
 - `encuesta2019.xlsx`: Survey responses for the 2019 course sessions ([xlsx](https://en.wikipedia.org/wiki/Microsoft_Office_XML_formats) format).

`figs` folder:
 - output figures in [svg](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) and [png](https://en.wikipedia.org/wiki/Portable_Network_Graphics) format