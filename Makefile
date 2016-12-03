all: copy utilities playerctl autorandr

copy: directories
	@echo "\n---copy---\n"
	cp .config/i3/config ~/.config/i3/config
	cp .config/i3status/config ~/.config/i3status/config
	cp .local/bin/lock ~/.local/bin/lock
        cp .local/bin/susp ~/.local/bin/susp

directories:
	@echo "\n---directories---\n"
	mkdir -p ~/Pictures/screen
	mkdir -p ~/.config/i3
	mkdir -p ~/.config/i3status
	mkdir -p ~/.local/bin

utilities:
	@echo "\n---utilities---\n"
	sudo apt install acpi ranger feh udiskie lxappearance imagemagick scrot arandr xautolock rofi compton xbacklight

playerctl:
	@echo "\n---playerctl---\n"
	wget https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb -O ~/Downloads/playerctl.deb
	sudo dpkg -i ~/Downloads/playerctl.deb

autorandr:
	@echo "\n---autorandr---\n"
	rm -rf ~/Downloads/autorandr
	git clone https://github.com/phillipberndt/autorandr --depth 1 ~/Downloads/autorandr
	cd ~/Downloads/autorandr && make deb && sudo dpkg -i autorandr-0.1.deb
	sudo udevadm control --reload-rules
