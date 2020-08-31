# Advancing pre-university students' computational thinking skills through an educational project based on tangible elements and virtual block-based programming

R script file for the paper ["Advancing pre-university students' computational thinking skills through an educational project based on tangible elements and virtual block-based programming"](https://onlinelibrary.wiley.com/journal/10990542)

> Trilles S, Granell C. 
> Advancing pre-university students' computational thinking skills through an educational project based on tangible elements and virtual block-based programming. 
> Computer Applications in Engineering Education
> DOI: 10.1002/cae.22319

https://img.shields.io/badge/2020-10.1002/cae.22319-brightgreen.svg

[![](https://img.shields.io/badge/CAEE-https://doi.org/10.1002/cae.22319-yellow.svg)](https://doi.org/10.1002/cae.22319)

This repository is archived on Zenodo:

[![DOI](https://www.zenodo.org/badge/DOI/10.5281/zenodo.3901461.svg)](https://doi.org/10.5281/zenodo.3901461)

## Reproduce Online

Click the "Binder" button below to open the R script file on [binder.org](https://mybinder.org/).

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/cgranell/caee2020/master?urlpath=rstudio)

In the RStudio page, open the file `analysis.R`, the _main analysis file_ that includes the complete analysis workflow. Then select "Source" or "Source > Source with Echo" to run the script. The two output figures will be accessible in the `Plots` pane, and stored in the folder `figs` as `fig04.png` and `fig05.png`

## Reproduce locally

Open the main analysis file `analysis.R` with RStudio. Then select "Source" or "Source > Source with Echo" to run the script. If you have errors, try running block-by-block to locate the problem.

The R script does not include code to install the required packages. Run `install.R` before `analysis.R` to install all dependencies in your local machine.


## Files in this repository

- `analysis.R`: R script file that generates the two main figures of the paper.
- `Dockerfile`: A recipe for the computational environment using [Docker](https://en.wikipedia.org/wiki/Docker_(software)).
- `install.R`: R script file executed during creation of the Docker image to install required dependencies.

`data` folder: 

- `datos-practica-UJI.csv`: Data items extracted from each individual course session held from 2017 to 2019 ([csv](https://en.wikipedia.org/wiki/Comma-separated_values) format).
- `encuesta2019.xlsx`: Survey responses for the 2019 course sessions ([xlsx](https://en.wikipedia.org/wiki/Microsoft_Office_XML_formats) format).

`figs` folder: output figures in [svg](https://en.wikipedia.org/wiki/Scalable_Vector_Graphics) and [png](https://en.wikipedia.org/wiki/Portable_Network_Graphics) format.

- `fig04.png`, `fig04.svg`: Percentage distribution of A-B-C sections per session. 
- `fig05.png`, `fig05.svg`: Results of the survey conducted in the 2019 edition of the 'Pràctica a l’UJI' (N=50).

 `docs` folder:

- `encuesta2019.pdf`: questionnaire in [pdf](https://en.wikipedia.org/wiki/PDF) format
 
 ## License

The documents in this repository are licensed under a [Creative Commons Attribution 4.0 International License](https://creativecommons.org/licenses/by/4.0/).

All contained code is licensed under the [Apache License 2.0](https://choosealicense.com/licenses/apache-2.0/).

The data used is licensed under a [Open Data Commons Attribution License](https://opendatacommons.org/licenses/by/).
 