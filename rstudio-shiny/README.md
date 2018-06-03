# rstudio-shiny: build docker image

Want spatial capabilities (especially rgdal, raster and leaflet packages) in a common R instance that can be used with:

- RStudio Server (port `8787`): integrated development environment for editing R code
- Shiny Server (port `3838`): web application framework

To do this, composed a Dockerfile from geoserver R version with Shiny tag:

- added the line `RUN export ADD=shiny && bash /etc/cont-init.d/add` to [rocker-org/geospatial:3.5.0/Dockerfile](https://github.com/rocker-org/geospatial/blob/master/3.5.0/Dockerfile) into new [ecoquants/nrel-docker:rstudio-shiny/Dockerfile](https://github.com/ecoquants/nrel-docker/blob/master/rstudio-shiny/Dockerfile) per [Deploying rocker/geospatial app to rocker/shiny? · Issue #235 · rocker-org/rocker](https://github.com/rocker-org/rocker/issues/235#issuecomment-300065850)

- added other needed packages: `leaflet`, `shinydashboard`

- `docker build` image, which takes ~ 3 hours:

  ```bash
  date; \
  docker build -t bdbest/rstudio-shiny:R-3.5-geospatial \
    "https://github.com/ecoquants/nrel-docker.git#master:rstudio-shiny"; \
  date
  ```
  on BB's Mac: 1.5 hr
  round 2 with FROM rocker/geospatial: 11 min
  round 3:
  - Sat Jun  2 18:57:05 PDT 2018
  - 

- `docker login` and `docker push` image

  ```bash
  docker login # registed as bdbest (bdbest@gmail.com)
  docker push "bdbest/rstudio-shiny:R-3.5-geospatial"
  ```

## Errors

installing to /usr/local/lib/R/site-library/httpuv/libs
** R
** demo
** preparing package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded
* DONE (httpuv)
* installing *source* package ‘shiny’ ...
** package ‘shiny’ successfully unpacked and MD5 sums checked
** R
** inst
** preparing package for lazy loading
** help
*** installing help indices
** building package indices
** testing if installed package can be loaded
Error: package or namespace load failed for ‘shiny’:
 .onLoad failed in loadNamespace() for 'shiny', details:
  call: .Call("_httpuv_getRNGState", PACKAGE = "httpuv")
  error: "_httpuv_getRNGState" not available for .Call() for package "httpuv"
Error: loading failed
Execution halted
ERROR: loading failed
* removing ‘/usr/local/lib/R/site-library/shiny’
* restoring previous ‘/usr/local/lib/R/site-library/shiny’
  