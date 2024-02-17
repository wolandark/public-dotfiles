#!/bin/sh

# Written By Woland

# Download the latest Gnu release of nekoray form github

#Dependency:
#          curl
#          wget
#          unzip (for unarchiving later)
#          sed
#          grep
#          tr

# https://github.com/wolandark

DL_LINK=$(curl -s https://api.github.com/repos/MatsuriDayo/nekoray/releases/latest  |  jq -r '.assets[1].browser_download_url')
DL_LINK2=$(curl -s https://api.github.com/repos/MatsuriDayo/nekoray/releases/latest  |  jq -r '.assets[2].browser_download_url')

axel "$DL_LINK"
axel "$DL_LINK2"

# curl -s https://api.github.com/repos/MatsuriDayo/nekoray/releases/latest \
# | grep browser_download_url \
# | grep -P linux \
# | sed 's/"browser_download_url": "//g' \
# | sed 's/",//g' \
# | tr -d '"' \
# | sed 's/$://g' \
# | xargs wget
