source "vars.sh"

# make directories
mkdir $DIR_SHINY_APPS
mkdir $DIR_SHINY_LOG
mkdir $DIR_GITHUB
mkdir $DIR_DATA
mkdir $DIR_TMP

# touch password file
touch $PASSWD
# TODO: manually add password; eg "echo p@ssw0rd > $PASSWD"

# load data from Google Drive/projects/nrel-ecoquants/data/app-data.zip
wget -O $DIR_TMP/z.$$ $DATA_ZIP_URL && 
   unzip -d $DIR_DATA $DIR_TMP/z.$$ &&
   rm $DIR_TMP/z.$$

# load app files from Github repo
git clone "https://github.com/ecoquants/nrel-uses.git" "$DIR_GITHUB/nrel-uses"

# add symlink: github/nrel-uses/app -> apps/uses
ln -s "$DIR_GITHUB/nrel-uses/app" "$DIR_SHINY_APPS/uses"
