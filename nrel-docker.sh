# paths to set for server instance
DIR_SHINY_APPS="/Users/bbest/docker-nrel/shiny-apps"
DIR_SHINY_LOG="/Users/bbest/docker-nrel/shiny-log"
DIR_GITHUB="/Users/bbest/docker-nrel/github"
DIR_DATA="/Users/bbest/docker-nrel/data"
PASSWD="/Users/bbest/.passwd"
DIR_TMP="/tmp"

# set variables
USER="ben"
TAG_DOCKER="bdbest/rstudio-shiny:R-3.5-geospatial"
DATA_ZIP_URL="https://drive.google.com/a/ecoquants.com/uc?id=1tdUmwJWYKAPc2iHJeavLh_Iyn8BmMeHH&export=download"

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

# load app files from Github repo
git clone "https://github.com/ecoquants/nrel-uses.git" "$DIR_GITHUB/nrel-uses"

# load data from Google Drive/projects/nrel-ecoquants/data/app-data.zip
wget -O $DIR_TMP/z.$$ $DATA_ZIP_URL && 
   unzip -d $DIR_DATA $DIR_TMP/z.$$ &&
   rm $DIR_TMP/z.$$

alias de="docker exec -i -t 'rstudio-shiny'"

# to quick install without rebuild for future...
PACKAGES="c('here','glue')"
de Rscript -e "install.packages($PACKAGES, repos = 'http://cran.us.r-project.org')"

# add symlink: github/nrel-uses/app -> apps/uses
de ln -s "/github/nrel-uses/app" "/srv/shiny-server/uses"

# Add symlinks for ease of navigation in RStudio
de ln -s "/data" "/home/$USER/data"; \
de ln -s "/github" "/home/$USER/github"; \
de ln -s "/srv/shiny-server" "/home/$USER/apps"; \
de ln -s "/var/log/shiny-server" "/home/$USER/log"
