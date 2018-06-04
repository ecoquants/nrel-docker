# nrel-docker

These [Docker](https://www.docker.com/what-docker) instructions are for running the NREL Competing Uses application ([github.com/ecoquants/nrel-uses:app](https://github.com/ecoquants/nrel-uses/tree/master/app)) in the NREL Amazon cluster using the following server software:

- [RStudio](https://www.rstudio.com/products/rstudio/) Server (port 8787): integrated development environment (IDE) for editing R code
- [Shiny](https://shiny.rstudio.com) Server (port 80): web application framework

To setup the Docker image, I ran the following Docker `build` per the `Dockerfile` and `README.md` in [rstudio-shiny/](https://github.com/ecoquants/nrel-docker/tree/master/rstudio-shiny). Now you should only need to prepare directories, modify and run the [nrel-docker.sh](https://github.com/ecoquants/nrel-docker/blob/master/nrel-docker.sh):

1. Setup the following directories on the server for read/write by users `shiny` (uid=998) and `ben` (uid=1000) and modify paths in [nrel-docker.sh](https://github.com/ecoquants/nrel-docker/blob/master/nrel-docker.sh):
  - `DIR_SHINY_APPS`
  - `DIR_SHINY_LOG`
  - `DIR_GITHUB`
  - `DIR_DATA`
  - `DIR_TMP`
  - `PASSWD`: password for user `ben` to be secretly shared
  
2. Run [nrel-docker.sh](https://github.com/ecoquants/nrel-docker/blob/master/nrel-docker.sh) with modified paths.

If successful, then you should be able to visit:

- http://localhost:8787 for RStudio:
  ![](https://assets.digitalocean.com/tutorial_images/kobMKpU.png)

- http://localhost/uses for NREL Competing Uses Shiny app:
  ![](https://github.com/ecoquants/nrel-uses/raw/master/app/images/app_screen.png)  
  