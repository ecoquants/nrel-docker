FROM rocker/geospatial
MAINTAINER "Ben Best" ben@ecoquants.com

## packages for github.com/ecoquants/nrel-uses:app
RUN install2.r --error \
    leaflet \
    shinydashboard

## add Shiny, per https://github.com/rocker-org/rocker/issues/235#issuecomment-299036810
RUN export ADD=shiny && bash /etc/cont-init.d/add