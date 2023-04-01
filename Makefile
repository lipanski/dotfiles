all: utilities brightness terminal vim rust i3 autorandr copy mail git

utilities:
	@echo "\n---utilities---\n"
	sudo apt install \
		python acpi ranger feh udiskie lxappearance imagemagick scrot arandr pavucontrol \
		xautolock rofi xbacklight jmtpfs fonts-font-awesome playerctl tldr \
		jq network-manager-openvpn curl git gnome-screensaver encfs \
		colordiff xclip silversearcher-ag htop pulsemixer zeal okular \
		blueman

extra:
	@echo "\n---extra---\n"
	sudo apt install \
		pinta

brightness:
	@echo "\n---brightness---\n"
	sudo apt install brightnessctl
	sudo chmod +s /usr/bin/brightnessctl

terminal:
	@echo "\n---terminal---\n"
	cp Xresources ~/.Xresources
	cp Xresources.light ~/.Xresources.light
	cp Xresources.present ~/.Xresources.present
	sudo apt install zsh rxvt-unicode
	test -d ~/.oh-my-zsh || sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	cp oh-my-zsh/custom/personal.zsh ~/.oh-my-zsh/custom/
	sed -i 's/^plugins=.*/plugins=(git urltools command-not-found z asdf)/' ~/.zshrc

vim:
	@echo "\n---vim---\n"
	sudo add-apt-repository ppa:neovim-ppa/stable
	sudo apt update
	sudo apt install neovim universal-ctags
	rm -rf ~/.vim/bundle/Vundle.vim
	git clone https://github.com/VundleVim/Vundle.vim.git --branch v0.10.2 ~/.vim/bundle/Vundle.vim
	cp vimrc ~/.vimrc
	mkdir -p ~/.config/nvim/
	cp config/nvim/init.vim ~/.config/nvim/
	cp -r config/nvim/UltiSnips/ ~/.config/nvim/UltiSnips
	cp ctags ~/.ctags

rust:
	curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-x86_64-unknown-linux-gnu.gz | gunzip -c - > ~/.local/bin/rust-analyzer
	chmod +x ~/.local/bin/rust-analyzer

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
	cp -r wallpapers/ ~/Pictures
	cp config/i3/config ~/.config/i3/config
	cp config/i3blocks/config.template ~/.config/i3blocks/config.template
	cp config/i3blocks/scripts/* ~/.config/i3blocks/scripts/
	cp -r config/feh/* ~/.config/feh
	cp -r config/git/* ~/.config/git
	cp local/bin/lock ~/.local/bin/lock
	cp local/bin/susp ~/.local/bin/susp
	cp local/bin/power ~/.local/bin/power
	sudo cp usr/share/X11/xkb/symbols/fl /usr/share/X11/xkb/symbols/fl

directories:
	@echo "\n---directories---\n"
	mkdir -p ~/Pictures/screen
	mkdir -p ~/.config/i3
	mkdir -p ~/.config/i3blocks/scripts
	mkdir -p ~/.config/feh
	mkdir -p ~/.config/git
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

nuc:
	sed -i 's/^font .*/font pango:monospace 14/g' ~/.config/i3/config
	sed -i '/^exec.*mbsync-daemon/d' ~/.config/i3/config
	sed -i '/^exec.*xautolock/d' ~/.config/i3/config
	sed -i 's/pieter-bruegel-hunters-in-the-snow\.jpg/pieter-the-younger-treasure-hunt.jpg/' ~/.config/i3/config
	sed -i 's/^URxvt\.font.*size=11.*/URxvt.font: xft:DejaVuSansMono:size=14:antialias=true/g' ~/.Xresources

spotify:
	curl -sS https://download.spotify.com/debian/pubkey.gpg | sudo apt-key add -
	echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update && sudo apt-get install spotify-client

asdf:
	test -d ~/.asdf || git clone https://github.com/asdf-vm/asdf.git --branch v0.7.8 ~/.asdf
	cp asdfrc ~/.asdfrc

calendar:
	sudo apt install vdirsyncer khal
	mkdir -p ~/.config/vdirsyncer
	cp config/vdirsyncer/config.template ~/.config/vdirsyncer/config.template
	mkdir -p ~/.config/khal
	cp config/khal/config.template ~/.config/khal/config.template
	mkdir -p ~/.calendar/personal
