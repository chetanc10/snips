#!/bin/bash

echo "Installer program for basic system utilities and libraries. Enter 'x' during any stage of questioning from me to kill me"

declare -a cutils=(vim cscope exuberant-ctags git at tree xpad minicom tftp-server subversion meld ssh curl rar unrar vlc tomboy nmap openssh-server openssh-client skype youtube-dl gparted synaptic wifi-radar wireshark qemu-system-x86)

install_cutils () {
	for i in "${cutils[@]}"
	do
		echo -ne "\n\n****Install '$i'?(y|n): "
		read answer
		[[ "$answer" == "n" ]] && continue
		exit_if_requested $answer
		# This case block handles normal installables and also special utilities/apps which are not simple/proper apt-get installables
		do_aptget_install=0
		case "$i" in
			"skype")
				echo -ne "Skype installation. DIY. Download the setup file for this distro and install and press enter here once done.. "
				read answer
				;;
			"youtube-dl")
				echo -ne "Default apt-get based installation seems to be buggy.. I'm approaching the website and get it for you "
				sudo curl -L https://yt-dl.org/latest/youtube-dl -o /usr/local/bin/youtube-dl
				sudo chmod a+rx /usr/local/bin/youtube-dl
				echo "Installed youtube-dl. You might consider using the following to resolve avconv errors during downloads using youtube-dl:"
				echo "youtube-dl -f 137+140 --prefer-ffmpeg <youtube-link>"
				;;
			"tftp-server")
				echo "Installing tftp-server dependencies: xinetd tftpd tftp"
				sudo apt-get install xinetd tftpd tftp
				echo "Setting up a hookup script to link a /tftpboot folder to tftp-server"
				sudo echo "service tftp
				{
					protocol        = udp
					port            = 69
					socket_type     = dgram
					wait            = yes
					user            = nobody
					server          = /usr/sbin/in.tftpd
					server_args     = /tftpboot
					disable         = no
				}" > /etc/xinetd.d/tftp
				echo "Setting up a user accessible /tftpboot folder to hold files for transfer by tftp-server"
				sudo mkdir -p /tftpboot && sudo chmod -R 666 /tftpboot && sudo chown -R nobody /tftpboot
				sudo /etc/init.d/xinetd restart
				;;
			"vim")
				echo "for VIM, c10 provides dotvim and dotvimrc in snips/cubuntu. The dotvim and dotvimrc have some plugins and keymaps which become very handy for a Vimmer. If you want them, I can place them in your HOME as .vim and .vimrc replacing existing ones. Shall I install dotvim/dotvimrc?(y|n): "
				read answer
				if [ "$answer" == "y" ]; then
					echo "Installing c10 collections for vim plugins and keymaps.. Good for you!"
					cp -r /home/vchn075/ChetaN/snips/cubuntu/dotvim /home/vchn075/.vim
					cp /home/vchn075/ChetaN/snips/cubuntu/dotvimrc /home/vchn075/.vimrc
				fi
				exit_if_requested $answer
				do_aptget_install=1
				;;
			*)
				do_aptget_install=1
				;;
		esac
		if [ $do_aptget_install -eq 1 ]; then
			echo -e "Installing $i"
			sudo apt-get install $i
		fi
	done
}

declare -a clibs=(libpcap-dev)

install_clibs () {
	for i in "${clibs[@]}"
	do
		echo -ne "\n\n****Install '$i'?(y|n): "
		read answer
		[[ "$answer" == "n" ]] && continue
		exit_if_requested $answer
		echo -e "Installing $i"
		sudo apt-get install $i
	done
}

declare -a c10sh=(extract.sh lpmode.sh pbar.sh renamer.sh stacker.sh vimindent.sh indent.vim)

install_c10sh () {
	for i in "${c10sh[@]}"
	do
		[[ ! -e ./"$i" ]] && continue
		echo -ne "\n\n****Install '$i'?(y|n): "
		read answer
		[[ "$answer" == "n" ]] && continue
		exit_if_requested $answer
		echo -e "Installing $i"
		sudo cp ./"$i" /bin/ && sudo chmod +x /bin/$i
	done
}

declare -a crems=(rhythmbox* brasero shotwell totem* empathy*)

install_crems () {
	for i in "${crems[@]}"
	do
		echo -ne "\n\n****Remove '$i'?(y|n): "
		read answer
		[[ "$answer" == "n" ]] && continue
		exit_if_requested $answer
		echo -e "UNInstalling $i"
		sudo apt-get remove --purge $i
	done
}

setup_c10bash () {
	sed -i -e 's/\~\/\.bash_aliases/\/home\/vchn075\/ChetaN\/snips\/cubuntu\/c10bashsetup.sh/g' /home/vchn075/.bashrc
}

exit_if_requested () {
	[[ "$1" == "x" ]] && echo -e "\nExiting c10setup..\n" && exit 0
}

echo -ne "Trying to install normal updates/dependencies. Shall I proceed?(y|n): "
read answer
if [ "$answer" == "y" ]; then
	sudo apt-get update
	sudo apt-get install -f
fi
exit_if_requested $answer

echo -ne "\nDo you need utility Installations? (y|n): "
read answer
[[ "$answer" == "y" ]] && install_cutils
exit_if_requested $answer

echo -ne "\nProceed to lib Installations? (y|n): "
read answer
[[ "$answer" == "y" ]] && install_clibs
exit_if_requested $answer

echo -ne "\nProceed to add c10 scripts to filesystem? (y|n): "
read answer
[[ "$answer" == "y" ]] && install_c10sh
exit_if_requested $answer

echo -e "\n***************************BEWARE***************************\nDURING UNINSTALLATIONS, PLEASE BE VERY CAREFUL AND OBSERVE WHICH PACKAGES ARE ADDITIONALLY REMOVED ALONG WITH REQUESTED UNINSTALLATION AND DECIDE IF YOU WANT TO PROCEED! OTHERWISE, KEEP AWAY FROM THAT AREA"
echo -ne "Proceed to UNInstallations? (y|n): "
read answer
[[ "$answer" == "y" ]] && install_crems
exit_if_requested $answer

echo -ne "\nSetup c10bash? (y/n): "
read answer
[[ "$answer" == "y" ]] && setup_c10bash
exit_if_requested $answer

echo -e "\nTata..!\n"

