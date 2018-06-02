## geospatial RStudio + Shiny

Want spatial capabilities (especially rgdal, raster and leaflet packages) in a common R instance that can be used with:

- RStudio Server: IDE for editing
- Shiny Server: web application framework

To do this, composed a Dockerfile and `docker build` Shiny into the rocker/geospatial Docker file by:

- adding the line `RUN export ADD=shiny && bash /etc/cont-init.d/add` to [rocker-org/geospatial/3.5.0/Dockerfile](https://github.com/rocker-org/geospatial/blob/master/3.5.0/Dockerfile) into new Dockerfile in [github.com/marinebon/docker-rstudio-shiny](https://github.com/marinebon/docker-rstudio-shiny)

- `docker build` image, which takes ~ 3 hours:

  ```bash
  docker build -t bdbest/rstudio-shiny:R-3.5-geospatial \
    https://github.com/ecoquants/nrel-docker.git#master:rstudio-shiny
  ```

- `docker login` and `docker push` image

  ```bash
  docker login # registed as bdbest (bdbest@gmail.com)
  docker push bdbest/rstudio-shiny:3.5-geospatial
  ```
  
Reference: [Deploying rocker/geospatial app to rocker/shiny? · Issue #235 · rocker-org/rocker](https://github.com/rocker-org/rocker/issues/235#issuecomment-300065850)
  