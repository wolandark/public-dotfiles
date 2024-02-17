#!/bin/sh

ocr_dir="$HOME/ocr"

if [ ! -d "$ocr_dir" ]; then mkdir -p "$ocr_dir"; fi

takeShot(){
	spectacle -r -b -n -o "$ocr_dir/ocr.png"
}

convert(){
	tesseract "$ocr_dir/ocr.png" "$ocr_dir/ocr"
}

sendToClipboard(){
	xsel -b < "$ocr_dir/ocr.txt"
}

takeShot
convert
sendToClipboard
