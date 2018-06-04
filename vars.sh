# path to set for server instance
DIR_S3="/Users/bbest/docker-nrel"

# set variables
USER="ben"
TAG_DOCKER="bdbest/rstudio-shiny:R-3.5-geospatial"
DATA_ZIP_URL="https://drive.google.com/a/ecoquants.com/uc?id=1tdUmwJWYKAPc2iHJeavLh_Iyn8BmMeHH&export=download"

# subdirectories of S3 storage folder
DIR_SHINY_APPS="$DIR_S3/shiny-apps"
DIR_SHINY_LOG="$DIR_S3/shiny-log"
DIR_GITHUB="$DIR_S3/github"
DIR_DATA="$DIR_S3/data"
PASSWD="$DIR_S3/.passwd"
DIR_TMP="$DIR_S3/tmp"