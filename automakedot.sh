all() 
{
    echo -e "\e[1m[ALL]\e[0m"
    rm -rf vim; cp $HOME/.vim vim -rf 2>/dev/null && echo "[+] vim new update ready" || echo "Error: $?"
    cp $HOME/.vimrc vim/vimrc 2>/dev/null && echo "[+] vim config new update ready" || echo "Error: $?"
    rm -rf tmux; cp $HOME/.tmux tmux -rf 2>/dev/null && echo "[+] tmux new update ready"|| echo "Error: $?"
    cp $HOME/.tmux.conf tmux/tmux.conf && echo "[+] tmux config new update ready" || echo "Error: $?"
    rm -rf i3; cp $HOME/.config/i3 i3 -rf 2>/dev/null && echo "[+] i3 config new update ready" || echo "Error: $?"
    rm -rf i3blocks; cp $HOME/.config/i3blocks i3blocks -rf && echo "[+] i3blocks config new update ready" || echo "Error: $?"
    rm -rf htop; cp $HOME/.config/htop htop -rf 2>/dev/null && echo "[+] htop new upate ready" || echo "Error: $?"
    rm -rf kitty; cp $HOME/.config/kitty kitty -rf 2>/dev/null && echo "[+] kitty new update ready" || echo "Error: $?"
    rm -rf zsh/zsh; mkdir zsh 2>/dev/null; cp $HOME/.zshrc zsh/zshrc;cp $HOME/.zsh zsh/zsh -rf 2>/dev/null && echo "[+] zsh config new update ready" || echo "Error: $?"
    rm -rf links; cp $HOME/.links/ links -rf 2>/dev/null && echo "[+] links config new update" || echo "Error: $?"
    rm -rf dunst; cp $HOME/.config/dunst dunst -rf 2>/dev/null && echo "[+] dunst config new update" || echo "Error: $?"
    rm -f dmenu; cp $HOME/.local/bin/dmenu dmenu && echo "[*] dmenu script new update" || echo "Error: $?"
}

pos()
{
    echo -e "\e[1m[POS]\e[0m"
    rm -f zsh/zsh/.history && echo ".history removed from zsh"
}

all
pos
