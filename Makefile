all: copy utilities playerctl autorandr

copy:
	echo "\n---copy---\n"
	mkdir -p ~/.config/i3
	cp .config/i3/config ~/.config/i3/config
	mkdir -p ~/.config/i3status
	cp .config/i3status/config ~/.config/i3status/config

utilities:
	echo "\n---utilities---\n"
	sudo apt install ranger feh udiskie lxappearance scrot arandr xautolock rofi compton arc-theme

playerctl:
	echo "\n---playerctl---\n"
	wget https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb -O ~/Downloads/playerctl.deb
	sudo dpkg -i ~/Downloads/playerctl.deb

autorandr:
	echo "\n---autorandr---\n"
	rm -rf ~/Downloads/autorandr
	git clone https://github.com/phillipberndt/autorandr --depth 1 ~/Downloads/autorandr
	cd ~/Downloads/autorandr && make deb && sudo dpkg -i autorandr-0.1.deb
	sudo udevadm control --reload-rules
