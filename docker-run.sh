source "vars.sh"

# if need to recreate docker container:
# docker stop rstudio-shiny; docker rm rstudio-shiny

# run docker, downloading image if needed
# bump memory to 8 GB for global.R `s_constraints = stack(constraints_grd)`
docker run --name "rstudio-shiny" \
  --restart unless-stopped \
  -p 8787:8787 -p 80:3838 \
  -v $DIR_DATA:/data \
  -v $DIR_GITHUB:/github \
  -v $DIR_SHINY_APPS:/srv/shiny-server \
  -v $DIR_SHINY_LOG:/var/log/shiny-server \
  -e ROOT=TRUE \
  -e USER=$USER -e PASSWORD=`cat $PASSWD` \
  -d -t $TAG_DOCKER

alias de="docker exec -i -t 'rstudio-shiny'"

# to quick install without rebuild for future...
PACKAGES="c('here','glue')"
de Rscript -e "install.packages($PACKAGES, repos = 'http://cran.us.r-project.org')"
