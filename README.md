# nrel-docker

These [Docker](https://www.docker.com/what-docker) instructions are for running the NREL Competing Uses application ([github.com/ecoquants/nrel-uses:app](https://github.com/ecoquants/nrel-uses/tree/master/app)) in the NREL Amazon cluster using the following server software:

- [RStudio](https://www.rstudio.com/products/rstudio/) Server (port 8787): integrated development environment (IDE) for editing R code
- [Shiny](https://shiny.rstudio.com) Server (port 80): web application framework

To setup the docker image, I ran `docker build` per the `Dockerfile` and `README.md` in [rstudio-shiny/](https://github.com/ecoquants/nrel-docker/tree/master/rstudio-shiny). The data and application files will be managed seperately in an Amazon S3 bucket from the server software, and both scripts source a common [`vars.sh`](./blob/master/vars.sh) (in which you probably need to update the `DIR_S3` variable definition):

1. [`setup-s3.sh`](./blob/master/setup-s3.sh) (data): sets up data and application files in Amazon S3 bucket
2. [`docker-run.sh`](./blob/master/docker-run.sh) (server): runs rstudio-shiny docker image and mounts paths

The following directories on the server should have read/write by users `shiny` (uid=998) and `ben` (uid=1000) in [vars.sh](https://github.com/ecoquants/nrel-docker/blob/master/nrel-docker.sh):

  - `DIR_S3`
    - `DIR_SHINY_APPS`
    - `DIR_SHINY_LOG`
    - `DIR_GITHUB`
    - `DIR_DATA`
    - `DIR_TMP`
    - `PASSWD`: text file containgin password for user `ben` to be secretly shared and used to log into RStudio IDE (port 8787)

If successful, then you should be able to visit:

- http://localhost:8787 for RStudio:
  ![](https://assets.digitalocean.com/tutorial_images/kobMKpU.png)

- http://localhost/uses for NREL Competing Uses Shiny app:
  ![](https://github.com/ecoquants/nrel-uses/raw/master/app/images/app_screen.png)  
  