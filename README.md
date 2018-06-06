# nrel-docker


## Quick Start

The following `docker run` command ...

```bash
# if need to recreate docker container:
#   docker stop "nrel-uses-app"; docker rm "nrel-uses-app"

# set password as environment variable
BEN_PASSWD="?set*password*!"

# run docker, downloading image if needed
docker run --name "nrel-uses-app" \
  --restart unless-stopped \
  -p 8787:8787 -p 80:3838 \
  -e ROOT=TRUE \
  -e USER=ben -e PASSWORD=$BEN_PASSWD \
  -d -t "bdbest/nrel-uses-app"
```
... should make the following available:

- http://localhost:8787 for RStudio:
  ![](https://assets.digitalocean.com/tutorial_images/kobMKpU.png)

- http://localhost/uses for NREL Competing Uses Shiny app (see [github.com/ecoquants/nrel-uses:app](https://github.com/ecoquants/nrel-uses/tree/master/app)):
  ![](https://github.com/ecoquants/nrel-uses/raw/master/app/images/app_screen.png)

## Server Software

These [Docker](https://www.docker.com/what-docker) instructions are for running the NREL Competing Uses application ([github.com/ecoquants/nrel-uses:app](https://github.com/ecoquants/nrel-uses/tree/master/app)) in the NREL Amazon cluster using the following server software:

- [RStudio](https://www.rstudio.com/products/rstudio/) Server (port 8787): integrated development environment (IDE) for editing R code
- [Shiny](https://shiny.rstudio.com) Server (port 80): web application framework

## Build Docker Images

### rstudio-shiny

Want spatial capabilities (especially rgdal, raster and leaflet packages) in a common R instance that can be used with:

- RStudio Server (port `8787`): integrated development environment for editing R code
- Shiny Server (port `3838`): web application framework

To do this, composed a Dockerfile from geoserver R version with Shiny tag:

- added the line `RUN export ADD=shiny && bash /etc/cont-init.d/add` to [rocker-org/geospatial:3.5.0/Dockerfile](https://github.com/rocker-org/geospatial/blob/master/3.5.0/Dockerfile) into new [ecoquants/nrel-docker:rstudio-shiny/Dockerfile](https://github.com/ecoquants/nrel-docker/blob/master/rstudio-shiny/Dockerfile) per [Deploying rocker/geospatial app to rocker/shiny? · Issue #235 · rocker-org/rocker](https://github.com/rocker-org/rocker/issues/235#issuecomment-300065850)

- added other needed packages, eg: `leaflet`, `shinydashboard`

- `docker build` image, which took ~ 1.5 hrs initially, then 2 min for updates:

  ```bash
  # docker rmi bdbest/rstudio-shiny:R-3.5-geospatial; \  
  date; \
  cd "/Users/bbest/github/nrel-docker/rstudio-shiny"; \
  docker build -t "bdbest/rstudio-shiny:R-3.5-geospatial" . \
  date
  ```

- `docker login` and `docker push` image (update: 1 min)

  ```bash
  docker login # registered as bdbest (bdbest@gmail.com)
  docker push "bdbest/rstudio-shiny:R-3.5-geospatial"
  ```
  
### nrel-uses-app

Note that the two copied folders are not in this Github repository because it's either duplicative with an existing Github repo (`github/`[nrel-uses](https://github.com/ecoquants/nrel-uses)) or contain files too big for Github (`data/`).

```bash
# docker rmi "bdbest/nrel-uses-app"; \  

# update github repo for app
cd "/Users/bbest/github/nrel-docker/nrel-uses-app/github/nrel-uses"; \
git pull; \

# build docker image
cd "/Users/bbest/github/nrel-docker/nrel-uses-app"; \
docker build -t "bdbest/nrel-uses-app" .; \
```

```bash
docker login # registered as bdbest (bdbest@gmail.com)
docker push "bdbest/nrel-uses-app"
```

