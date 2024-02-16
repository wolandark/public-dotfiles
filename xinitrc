#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

xsetroot -cursor_name left_ptr
xset r rate 250 60
xinput --set-prop 13 'libinput Accel Speed' 1

exec i3

# ============================================
#exec $HOME/.screenlayout/bspwm-two-dis.sh &
# feh --bg-scale '/home/woland/Pictures/HD/NEW/RED/wallpaperflare.com_wallpaper(8).jpg' '/home/woland/Pictures/HD/NEW/RED/wallpaperflare.com_wallpaper(8).jpg'
# exec bspwm
# sxhkd -c $HOME/.config/berry/berry/sxhkdrc &
# exec berry
# exec openbox
# albert &
#export XDG_SESSION_TYPE=x11
#export GDK_BACKEND=x11
#exec gnome-session
# exec sxhkd -c $HOME/.config/sxhkd/sxhkdrc-bsp &
# exec nitrogen --restore &
# exec sxhkd -c $HOME/.config/sxhkd/sxhkdrc &
# exec ~/.screenlayout/i3maindisplay.sh &
# exec xfce4-session
# exec fvwm-crystal
# exec wmaker
# exec ratpoison
# exec twm 
# xclock -geometry 50x50-1+1 &
# xterm -geometry 80x50+494+51 &
# xterm -geometry 80x20+494-0 &
# exec xterm -geometry 80x66+0+0 -name login
# xmodmap -e "keycode 135 = Super_L"
# xmodmap -e 'clear Lock' -e 'keycode 66 = Escape'
# xmodmap -e 'clear Lock' -e 'keycode 9 = Caps_Lock'
# xrdb ~/.Xresources &
# exec ~/.screenlayout/horizontal.sh &
