all: utilities i3 playerctl autorandr copy mail calendar

copy: directories
	@echo "\n---copy---\n"
	cp config/i3/config ~/.config/i3/config
	cp config/i3blocks/config.template ~/.config/i3blocks/config.template
	cp config/i3blocks/scripts/* ~/.config/i3blocks/scripts/
	cp config/feh/keys ~/.config/feh/keys
	cp local/bin/lock ~/.local/bin/lock
	cp local/bin/susp ~/.local/bin/susp
	cp local/bin/poll-battery-uevent ~/.local/bin/poll-battery-uevent

directories:
	@echo "\n---directories---\n"
	mkdir -p ~/Pictures/screen
	mkdir -p ~/.config/i3
	mkdir -p ~/.config/i3blocks/scripts
	mkdir -p ~/.config/feh
	mkdir -p ~/.local/bin

utilities:
	@echo "\n---utilities---\n"
	sudo apt install acpi ranger feh udiskie lxappearance imagemagick scrot arandr xautolock rofi compton xbacklight jmtpfs

playerctl:
	@echo "\n---playerctl---\n"
	wget https://github.com/acrisci/playerctl/releases/download/v0.5.0/playerctl-0.5.0_amd64.deb -O ~/Downloads/playerctl.deb
	sudo dpkg -i ~/Downloads/playerctl.deb

i3:
	sudo apt install i3 i3blocks

autorandr:
	@echo "\n---autorandr---\n"
	rm -rf ~/Downloads/autorandr
	git clone https://github.com/phillipberndt/autorandr --depth 1 ~/Downloads/autorandr
	cd ~/Downloads/autorandr && make deb && sudo dpkg -i autorandr-0.1.deb
	sudo udevadm control --reload-rules

mail:
	sudo apt install mutt isync abook w3m urlscan python-keyring
	cp mbrsync.template ~/.mbrsync.template
	cp muttrc.template ~/.muttrc.template
	cp mutt/template ~/.mutt/template
	cp local/bin/keyring ~/.local/bin/keyring
	cp local/bin/mbsync-daemon ~/.local/bin/mbsync-daemon

calendar:
	sudo apt install gcalcli
