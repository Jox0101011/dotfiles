startup=("
 Welcome $USER to my dotfiles, my name is hzr and i will go to help
 you in this installation...
    ")

init() {
    echo -e "\e[1;34m${startup[0]}\n\e[0m"
    sleep 2;tput bold setaf 49;tput blink ;printf "[press enter]\n"; tput sgr0
    read -r sc
    tput bold setaf 44;echo "[do i like create backup your .config? and others?](Y/n)"; tput sgr0
    read -r prompt
    if [ "$prompt" = "y" ] || [ -z "$prompt" ]; then
        mkdir backup 2>/dev/null || echo -e "\e[1;31m BACKUP HAS EXISTS\e[0m"
        sudo cp $HOME/.config backup/config -r || echo -e "\e[1;31m config directory not found \e[0m"
        sudo cp $HOME/.vimrc backup/vimrc || echo -e "\e[1;31m vimrc not found"
        sudo cp $HOME/.vim backup/vim -r || echo -e "\e[1;31m Vim directory not found \e[0m"
        sudo cp $HOME/.tmux.conf backup/tmux.conf || echo -e "\e[1;31m tmux.conf not found\e[0m"
        tput bold setaf 84;echo "[cp confgs -> $(pwd)/backup]"
    elif [ "$?" -eq 2 ]; then
        tput bold setaf 1;echo "errors occurred :("
    fi
    if [ "$prompt" = "n" ]; then
        tput bold setaf 3; echo "ok.."
        continue
    fi

    
}
init
