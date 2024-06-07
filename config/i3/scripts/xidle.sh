#!/bin/dash

while :;
do 
	xidle -timeout 1200 -program /usr/local/bin/slock #-ne -delay 0 -area 1
done
