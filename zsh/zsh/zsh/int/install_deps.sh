if [[ ! -f /usr/bin/{git,zsh,eza,bat,tmux,vim} ]]; then
    if [[ -f /usr/bin/pacman ]]; then
        yes | sudo pacman -S <<EOF
    $(cat $HOME/.zsh/int/packages)
EOF
elif [[ -f /usr/bin/apt ]]; then
    yes | sudo apt install <<EOF
    $(cat $HOME/.zsh/int/packages)
EOF
    fi
fi
