#!/usr/bin/env bash 

install_yay()
{
	git clone https://aur.archlinux.org/yay.git
	cd yay || return 
	makepkg -si
}
install_yay

display_counters() {
    echo -e "\033[7;35mPackages installed: $installed_count\033[0m"
    echo -e "\033[7;35mPackages remaining: $remaining_count\033[0m"
}

is_pkg_installed() {
    pacman -Q "$1" &>/dev/null
}

installed_count=0
remaining_count=${#pkgs[@]}

pkgs=(
	adwaita-cursors
	alsa-firmware
	alsa-lib
	alsa-plugins
	alsa-utils 
	amfora
	ark
	audacious
	awesome-terminal-fonts 
	axel
	base-devel
	bash-completion
	bat
	bc
	chromium 
	curl
	dash
	doas
	docker
	duf
	dunst
	eza
	fbset 
	fd
	feh
	ffmpeg
	ffmpegthumbnailer
	figlet
	firefox
	flameshot 
	fuse2
	git 
	glava
	glow
	gthumb 
	gvim 
	hexchat
	htop
	imagemagick
	jq
	kate
	konsole
	ksh
	kvantum
	leafpad
	lf
	libnewt
	libnotify 
	lxappearance-gtk3
	lxqt-archiver
	man-db
	man-pages
	mg
	mocp
	mpc
	mpd 
	mpv 
	ncdu
	ncmpcpp
	neofetch
	nitrogen
	nodejs 
	noto-fonts
	npm 
	ntfs-3g
	openssh 
	pandoc-bin
	pass
	pcmanfm 
	proxychains-ng
	pulsemixer
	qbittorrent 
	qt5ct
	ranger
	realtime-privileges
	ripgrep-all
	rofi 
	rsync
	screenkey
	scrot
	shellcheck-bin
	sxhkd
	task
	telegram-desktop
	tesseract
	tesseract-data-eng
	the_silver_searcher
	thunar-archive-plugin
	thunar-volman
	thunderbird 
	tmux 
	toilet
	trash-cli
	ttf-hack-nerd
	ttf-liberation-mono-nerd
	tumbler
	udiskie
	udisks2
	ugrep
	unzip
	vi
	vifm 
	vlc
	w3m
	wget
	xclip
	xcompmgr
	xorg-modmap
	xorg-xinit 
	xorg-xkill 
	xorg-xprop 
	xorg-xrandr 
	xorg-xrdb 
	xorg-xset 
	xorg-xwininfo
	xsel 
	xterm
	yarn
	yt-dlp
	z
	zathura
	zathura-cb
	zathura-djvu
	zathura-pdf-mupdf
	zathura-ps
	zenity 
)

aur=(
	7-zip-bin
	albert 
	autotiling
	bottom
	catppuccin-gtk-theme-frappe
	catppuccin-gtk-theme-latte
	catppuccin-gtk-theme-macchiato
	catppuccin-gtk-theme-mocha
	cava
	fsearch 
	i3-swallow-git 
	jcal
	kvantum-theme-catppuccin-git
	libvirt-python
	lightly-qt
	lsix-git
	noto-color-emoji-fontconfig
	poppler
	powerline-fonts 
	python-jdatetime
	qogir-gtk-theme-git
	qogir-icon-theme-git 
	selectdefaultapplication-git
	simplescreenrecorder-bin
	transset-df
	ttf-firacode-nerd 
	ttf-font-awesome-5
	ttf-roboto-mono-nerd 
	ttf-ubraille
	urlview
	vazirmatn-code-fonts
	vazirmatn-fonts
	waterfox-bin
	xidle
	xidlehook
	xkb-switch 
)

for i in "${pkgs[@]}" 
do
	if ! is_pkg_installed "$i"
	then
		sudo pacman -S "$i" --noconfirm
		((installed_count++))
	else
		echo "Package \"$i\" is already installed. Skipping ..."
	fi
	((remaining_count--))
	echo -e "\033[7;32mInstalled \"$i\"! Continuing ...\033[0m"
	display_counters
	sleep 0.1
done

echo -e "\033[7;34mInstalling AUR Packages Now ...\033[0m"

for i in "${aur[@]}" 
do
	if ! is_pkg_installed "$i"
	then
		yay -S "$i" --noconfirm
		((installed_count++))
	else
		echo "Package \"$i\" is already installed. Skipping ..."
	fi
	((remaining_count--))
	echo -e "\033[7;32mInstalled \"$i\"! Continuing ...\033[0m"
	display_counters
	sleep 0.1
done

echo -e "\033[7;32mCopying Files Around ...\033[0m"
rsync -av ~/public-dotfiles/config/ ~/.config/
sleep 1

echo -e "\033[7;32mCopying Shell Files ...\033[0m"
rsync -av ~/public-dotfiles/bashrc ~/.bashrc
rsync -av ~/public-dotfiles/aliases ~/.aliases
rsync -av ~/public-dotfiles/bash_profile ~/.bash_profile
rsync -av ~/public-dotfiles/profile ~/.profile
rsync -av ~/public-dotfiles/tmux.conf ~/.tmux.conf
rsync -av ~/public-dotfiles/kshrc ~/.kshrc
sleep 1

echo -e "\033[7;32mInstalling TPM for Tmux ...\033[0m"
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo -e "\033[7;32mCopying Setting Files ...\033[0m"
rsync -av ~/public-dotfiles/nk.sh ~/nk.sh
rsync -av ~/public-dotfiles/taskrc ~/.taskrc
rsync -av ~/public-dotfiles/exrc ~/.exrc
rsync -av ~/public-dotfiles/Xresources ~/.Xresources
rsync -av ~/public-dotfiles/Xmodmap ~/.Xmodmap
rsync -av ~/public-dotfiles/xinitrc ~/.xinitrc
rsync -av ~/public-dotfiles/ocr/ ~/ocr/
rsync -av ~/public-dotfiles/screenlayout/ ~/.screenlayout/
sleep 1

echo -e "\033[7;32mCloning Wim and Downloading Nekoray Now\033[0m"
git clone -b Devel https://github.com/wolandark/wim.git 
~/public-dotfiles/NEKO/updater.sh 
sleep 1

echo -e "\033[7;32mCopying Local Bin Files ...\033[0m"
mkdir -p ~/.local/bin
rsync -av ~/public-dotfiles/local-bin/ ~/.local/bin/
sleep 1

echo -e "\033[7;32mCopying Proxy, Keyboard and Doas Files ...\033[0m"
sudo rsync -av ~/public-dotfiles/proxychains.conf /etc/proxychains.conf
sudo rsync -av ~/public-dotfiles/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
sudo rsync -av ~/public-dotfiles/doas.conf /etc/doas.conf
sudo chown root:root /etc/doas.conf
sleep 1
#
echo -e "\033[7;32mCopying Pictures ...\033[0m"
mkdir -p ~/Pictures
rsync -av ~/public-dotfiles/catppuccin-wallpapers ~/Pictures/
rsync -av ~/public-dotfiles/Dracula-Wallpapers ~/Pictures/
echo -e "\033[7;32mFinished Copying Files\033[0m"
sleep 1

echo -e "\033[7;32mMaking slock Now\033[0m"
cd ~/.config/slock/ && sudo make install && cd || return
echo -e "\033[7;32mFinished Making slock\033[0m"
echo -e "\033[7;32mMaking dmenu Now\033[0m"
cd ~/.config/dmenu/ && sudo make install && cd || return
echo -e "\033[7;32mFinished Making dmenu\033[0m"
sleep 1

echo -e "\033[7;32mInstalling FZF Now\033[0m"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
cd || return
sleep 1

echo -e "\033[7;32mSetting Up Some Themes Now\033[0m"
# git clone https://github.com/catppuccin/xfce4-terminal.git
# mkdir -p ~/.local/share/xfce4/terminal/colorschemes/
# rsync -av ~/xfce4-terminal/src/ ~/.local/share/xfce4/terminal/colorschemes/
# sleep 1

echo -e "\033[7;32mSetting Rofi Themes and Scripts Now\033[0m"
git clone --depth=1 https://github.com/adi1090x/rofi.git
chmod +x rofi/setup.sh
rofi/setup.sh
sed -i 's/style-1/style-7/' ~/.config/rofi/powermenu/type-2/powermenu.sh

echo -e "\033[7;32mSetting QT5CT Themes Now\033[0m"
mkdir -p ~/.config/qt5ct/colors/
curl -o ~/.config/qt5ct/colors/Catppuccin-Frappe.conf https://raw.githubusercontent.com/catppuccin/qt5ct/main/themes/Catppuccin-Frappe.conf
curl -o ~/.config/qt5ct/colors/Catppuccin-Latte.conf https://raw.githubusercontent.com/catppuccin/qt5ct/main/themes/Catppuccin-Latte.conf
curl -o ~/.config/qt5ct/colors/Catppuccin-Macchiato.conf https://raw.githubusercontent.com/catppuccin/qt5ct/main/themes/Catppuccin-Macchiato.conf
curl -o ~/.config/qt5ct/colors/Catppuccin-Mocha.conf https://raw.githubusercontent.com/catppuccin/qt5ct/main/themes/Catppuccin-Mocha.conf

echo -e "\033[7;32mDownloading Pistol Now\033[0m"
wget https://github.com/doronbehar/pistol/releases/download/v0.4.2/pistol-static-linux-x86_64
chmod +x pistol-static-linux-x86_64
mv pistol-static-linux-x86_64 ~/.config/lf/

echo -e "\033[7;32mInstalling Qemu Now\033[0m"
sudo pacman -S qemu-full iptables-nft dnsmasq 
sudo usermod -aG libvirt $USER
sudo usermod -aG realtime $USER
sudo systemctl enable --now libvirtd.service
sudo systemctl enable --now virtlogd.service
sudo systemctl enable --now libvirtd.socket
sudo pacman -S virt-manager

echo -e "\n\t\033[6;7;32mAll Done\033[0m"

