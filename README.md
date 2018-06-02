# nrel-docker

These [Docker](https://www.docker.com/what-docker) instructions are for running the NREL Competing Uses application ([github.com/ecoquants/nrel-uses:app](https://github.com/ecoquants/nrel-uses/tree/master/app)) in the NREL Amazon cluster using the following server software:

- [RStudio](https://www.rstudio.com/products/rstudio/) Server (port `8787`): integrated development environment (IDE) for editing R code
- [Shiny](https://shiny.rstudio.com) Server (port `3838`): web application framework

This involves two steps:

1. Docker `build` of server software image: [rstudio-shiny/](https://github.com/ecoquants/nrel-docker/tree/master/rstudio-shiny)

2. Docker `run` of the image in the Amazon cluster: [nrel-docker.sh](https://github.com/ecoquants/nrel-docker/blob/master/nrel-docker.sh)