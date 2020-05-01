all: utilities terminal vim i3 autorandr copy mail git

utilities:
	@echo "\n---utilities---\n"
	sudo apt install \
		python acpi ranger feh udiskie lxappearance imagemagick scrot arandr pavucontrol \
		xautolock rofi xbacklight jmtpfs fonts-font-awesome playerctl \
		jq network-manager-openvpn curl git \
		colordiff xclip silversearcher-ag htop

terminal:
	@echo "\n---terminal---\n"
	cp Xresources ~/.Xresources
	sudo apt install zsh rxvt-unicode
	test -d ~/.oh-my-zsh || sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

vim:
	@echo "\n---vim---\n"
	sudo apt install neovim
	rm -rf ~/.vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git --branch v0.10.2 ~/.vim/bundle/Vundle.vim
	cp vimrc ~/.vimrc
	mkdir -p ~/.config/nvim/
	cp config/nvim/init.vim ~/.config/nvim/

i3:
	sudo apt install i3 i3blocks

autorandr:
	@echo "\n---autorandr---\n"
	rm -rf ~/Downloads/autorandr
	git clone https://github.com/phillipberndt/autorandr --branch 1.10 --depth 1 ~/Downloads/autorandr
	cd ~/Downloads/autorandr && make deb && sudo dpkg -i autorandr-1.10.deb
	sudo udevadm control --reload-rules

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

mail:
	sudo apt install neomutt isync abook w3m urlscan python-keyring ripmime notmuch
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
	mkdir -p ~/.mail/.notmuch
	cp notmuch-config.template ~/.notmuch-config.template
	cp notmuch-tags ~/.notmuch-tags
	cp local/bin/keyring ~/.local/bin/keyring
	cp local/bin/mbsync-daemon ~/.local/bin/mbsync-daemon
	mkdir -p ~/.abook

git:
	cp gitconfig.template ~/.gitconfig.template

thinkpad:
	sudo mkdir -p /etc/X11/xorg.conf.d/
	sudo cp etc/X11/xorg.conf.d/90-touchpad.conf /etc/X11/xorg.conf.d/90-touchpad.conf

spotify:
	curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install spotify-client
