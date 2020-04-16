all: utilities terminal vim i3 playerctl autorandr copy mail git

copy: directories
	@echo "\n---copy---\n"
	cp config/i3/config ~/.config/i3/config
	cp config/i3blocks/config.template ~/.config/i3blocks/config.template
	cp config/i3blocks/scripts/* ~/.config/i3blocks/scripts/
	cp config/feh/keys ~/.config/feh/keys
	cp local/bin/lock ~/.local/bin/lock
	cp local/bin/susp ~/.local/bin/susp
	sudo cp usr/share/X11/xkb/symbols/fl /usr/share/X11/xkb/symbols/fl

directories:
	@echo "\n---directories---\n"
	mkdir -p ~/Pictures/screen
	mkdir -p ~/.config/i3
	mkdir -p ~/.config/i3blocks/scripts
	mkdir -p ~/.config/feh
	mkdir -p ~/.local/bin

utilities:
	@echo "\n---utilities---\n"
	sudo apt install \
		acpi ranger feh udiskie lxappearance imagemagick scrot arandr \
		xautolock rofi compton xbacklight jmtpfs fonts-font-awesome \
		jq zsh network-manager-openvpn curl git \
		colordiff xclip silversearcher-ag

terminal:
	@echo "\n---terminal---\n"
	sudo apt install rxvt-unicode
	cp Xresources ~/.Xresources

vim:
	@echo "\n---vim---\n"
	sudo apt install vim
	cp vimrc ~/.vimrc

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
	sudo apt install mutt isync abook w3m urlscan python-keyring ripmime notmuch
	cp mailcap ~/.mailcap
	mkdir -p ~/.config/mutt
	cp config/mutt/colors-solarized-light-256.muttrc ~/.config/mutt/colors-solarized-light-256.muttrc
	cp mbsyncrc.template ~/.mbsyncrc.template
	cp muttrc ~/.muttrc
	mkdir -p ~/.mutt/tmp
	mkdir -p ~/.mutt/signatures
	touch ~/.mutt/signatures/default
	cp mutt/template ~/.mutt/template
	cp mutt/accounts.template ~/.mutt/accounts.template
	cp notmuch-config.template ~/.notmuch-config.template
	cp notmuch-tags ~/.notmuch-tags
	cp local/bin/keyring ~/.local/bin/keyring
	cp local/bin/mbsync-daemon ~/.local/bin/mbsync-daemon
	mkdir -p ~/.abook

git:
	cp gitconfig.template ~/.gitconfig.template

