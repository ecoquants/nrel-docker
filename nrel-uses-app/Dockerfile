FROM bdbest/rstudio-shiny:R-3.5-geospatial
MAINTAINER "Ben Best" ben@ecoquants.com

# stage files in /home/ben
RUN mkdir -p /home/ben
COPY ./data/ /home/ben/data/
COPY ./github/ /home/ben/github/

# symlink nrel-uses app to where Shiny serves apps
RUN ln -s /home/ben/github/nrel-uses/app /srv/shiny-server/uses

# symlink folders for convenient access when logging into RStudio as ben
RUN ln -s /srv/shiny-server /home/ben/shiny-apps
RUN ln -s /var/log/shiny-server /home/ben/shiny-log