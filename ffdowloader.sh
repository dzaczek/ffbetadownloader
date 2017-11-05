#!/bin/bash


files=firefox-beta.tar.gz
dirdown="/tmp/"
patches=$dirdown$files
config="/etc/ffdown.conf"
targetdir="/opt"

function installff {

	tar -xvf $1 -C $2
}

wget "https://download.mozilla.org/?product=firefox-beta-latest&os=linux64&lang=en-US" -O $patches

sumcontrol=$(md5sum $patches)


FILE=$1     
if [ -f $config ]; then
	echo "File $config exists."
	sumold=$(cat $config)
	if [ "${sumold% *}" != "${sumcontrol% *}" ]; then
	       installff $patches $targetdir
	       echo $sumcontrol > $config
	else
	       echo "SAME version nothing to do"
	fi	       


else
	      echo "File $config does not exist."
	      echo $sumcontrol > $config
	      installff $patches $targetdir
fi


