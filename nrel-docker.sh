# Change these local paths to work on instance
DIR_SHINY_APPS="/Users/bbest/docker-nrel/shiny-apps"
DIR_SHINY_LOG="/Users/bbest/docker-nrel/shiny-log"
DIR_GITHUB="/Users/bbest/docker-nrel/github"
DIR_DATA="/Users/bbest/docker-nrel/data"
USER="ben"
PASSWD="/Users/bbest/.passwd"

# Load app files from Github repo
git clone "https://github.com/ecoquants/nrel-uses.git" "$DIR_GITHUB/nrel-uses"

# If need to recreate docker container:
# docker rm rstudio-shiny

# Run docker, downloading if needed
docker run --name "rstudio-shiny" \
  --restart unless-stopped \
  -p 8787:8787 -p 3838:3838 \
  -v $DIR_DATA:/data \
  -v $DIR_GITHUB:/github \
  -v $DIR_SHINY_APPS:/srv/shiny-server \
  -v $DIR_SHINY_LOG:/var/log/shiny-server \
  -e ROOT=TRUE \
  -e USER=$USER -e PASSWORD=`cat $PASSWD` \
  -d -t bdbest/rstudio-shiny:R-3.4-geospatial

# Add symlink: github/nrel-uses/app -> apps/uses
docker exec -i -t "rstudio-shiny" ln -s "/github/nrel-uses/app" "/srv/shiny-server/uses"

# Install packages (TODO: update in Dockerfile with upgrade to 3.5, ie rstudio-shiny:R-3.5-geospatial)
PACKAGES="c('leaflet','shinydashboard')"
docker exec -i -t "rstudio-shiny" Rscript -e "install.packages($PACKAGES, repos = 'http://cran.us.r-project.org')"

# Add symlinks for ease of navigation in RStudio
docker exec -i -t "rstudio-shiny" ln -s "/data" "/home/$USER/data"
docker exec -i -t "rstudio-shiny" ln -s "/github" "/home/$USER/github"
docker exec -i -t "rstudio-shiny" ln -s "/srv/shiny-server" "/home/$USER/apps"
docker exec -i -t "rstudio-shiny" ln -s "/var/log/shiny-server" "/home/$USER/log"