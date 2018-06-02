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

alias de="docker exec -i -t 'rstudio-shiny'"

# Add symlink: github/nrel-uses/app -> apps/uses
de ln -s "/github/nrel-uses/app" "/srv/shiny-server/uses"

# Packages installed already with Dockerfile build 3.5; quick install without rebuild for future...
#PACKAGES="c('leaflet','shinydashboard')"
#de -i -t "rstudio-shiny" Rscript -e "install.packages($PACKAGES, repos = 'http://cran.us.r-project.org')"

# Add symlinks for ease of navigation in RStudio
de ln -s "/data" "/home/$USER/data"
de ln -s "/github" "/home/$USER/github"
de ln -s "/srv/shiny-server" "/home/$USER/apps"
de ln -s "/var/log/shiny-server" "/home/$USER/log"