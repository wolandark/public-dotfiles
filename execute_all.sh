#!/bin/bash

# Get the MIME type of the file
mime=$(file --mime-type -b "$1" 2>/dev/null)

# Handle different MIME types with a case statement
case "$mime" in
	text/*)
		# Use vim for text files
		vim "$1"
		;;
	*)
		xdg-open "$1" >/dev/null 2>&1
		;;
esac

exit 0
