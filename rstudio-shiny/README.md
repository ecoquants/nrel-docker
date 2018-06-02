# Build rstudio-shiny docker image

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
  on BB's Mac, start: Sat Jun  2 15:12:34 PDT 2018
  end:  ?

- `docker login` and `docker push` image

  ```bash
  docker login # registed as bdbest (bdbest@gmail.com)
  docker push "bdbest/rstudio-shiny:R-3.5-geospatial"
  ```

  