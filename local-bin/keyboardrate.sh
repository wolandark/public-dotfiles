#!/bin/dash

while :; do
	setxkbmap -option caps:escape
	setxkbmap -layout us,ir
	xmodmap -e "keycode 135 = Super_L"
	xset r rate 270 60
	sleep 60
done&
# xmodmap -e 'clear Lock' -e 'keycode 66 = Escape'
# xmodmap -e 'clear Lock' -e 'keycode 9 = Caps_Lock'
# xset r rate 250 40
