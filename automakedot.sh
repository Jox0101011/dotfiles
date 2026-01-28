all() 
{
    cp $HOME/.vim vim -r 2>/dev/null && echo "[+] vim new update ready" || echo "Error: $?"
    cp $HOME/.vimrc vim/vimrc 2>/dev/null && echo "[+] vim config new update ready" || echo "Error: $?"
    cp $HOME/.tmux tmux -r 2>/dev/null && echo "[+] tmux new update ready"|| echo "Error: $?"
    cp $HOME/.tmux.conf tmux/tmux.conf && echo "[+] tmux config new update ready" || echo "Error: $?"
    cp $HOME/.config/i3 i3 -r 2>/dev/null && echo "[+] i3 config new update ready" || echo "Error: $?"
    cp $HOME/.config/i3blocks i3blocks -r && echo "[+] i3blocks config new update ready" || echo "Error: $?"
    cp $HOME/.config/htop htop -r 2>/dev/null && echo "[+] htop new upate ready" || echo "Error: $?"
    cp $HOME/.config/kitty kitty -r 2>/dev/null && echo "[+] kitty new update ready" || echo "Error: $?"
    mkdir zsh 2>/dev/null; cp $HOME/.zsh* zsh/ -r 2>/dev/null && echo "[+] zsh config new update ready" || echo "Error: $?"
}

all
