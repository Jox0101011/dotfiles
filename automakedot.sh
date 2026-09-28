#!/usr/bin/bash

all() 
{
    echo -e "\e[1;5m[ALL]\e[0m"
    rm -rf vim; mkdir vim; cp $HOME/.vim vim/vim -rf 2>/dev/null && echo "[+] vim new update ready" || echo "Error: $?"
    cp $HOME/.vimrc vim/vimrc 2>/dev/null && echo "[+] vim config new update ready" || echo "Error: $?"
    rm -rf tmux; cp $HOME/.tmux tmux -rf 2>/dev/null && echo "[+] tmux new update ready"|| echo "Error: $?"
    cp $HOME/.tmux.conf tmux/tmux.conf && echo "[+] tmux config new update ready" || echo "Error: $?"
    rm -rf sway; cp $HOME/.config/sway sway -rf 2>/dev/null && echo "[+] sway config new update ready" || echo "Error: $?"
    rm -rf htop; cp $HOME/.config/htop htop -rf 2>/dev/null && echo "[+] htop new upate ready" || echo "Error: $?"
    rm -rf foot; cp $HOME/.config/foot foot -rf 2>/dev/null && echo "[+] foot new update ready" || echo "Error: $?"
    rm -rf zsh/zsh; mkdir zsh 2>/dev/null; cp $HOME/.zshrc zsh/zshrc;cp $HOME/.zsh zsh/zsh -rf 2>/dev/null && echo "[+] zsh config new update ready" || echo "Error: $?"
    rm -rf links; cp $HOME/.links/ links -rf 2>/dev/null && echo "[+] links config new update ready" || echo "Error: $?"
    rm -rf dunst; cp $HOME/.config/dunst dunst -rf 2>/dev/null && echo "[+] dunst config new update ready" || echo "Error: $?"
    rm -rf localbin; cp -r $HOME/.local/bin/ localbin/ && echo "[+] dmenu script new update ready" || echo "Error: $?"
    cp $HOME/.config/endcord/config.ini endcord/config.ini 2>/dev/null && echo "[+] endcord config new update ready" || echo "Error: $?"
    rm -f qutebrowser/config.py; cp $HOME/.config/qutebrowser/config.py qutebrowser/config.py 2>/dev/null && echo "[+] qutebrowser config add" || echo "Error: $?"
    rm -rf yambar; cp $HOME/.config/yambar yambar 2>/dev/null && echo "[+] yambar config add" || echo "Error: $?"
    rm -rf irssi; cp -r $HOME/.irssi irssi 2>/dev/null && echo "[+] irssi config add" || echo "Error: $?"
}

pos()
{
    echo -e "\e[1;5m[POS]\e[0m"
    rm -f zsh/zsh/.history && echo "[-] .history removed from zsh"
    rm -fr vim/vim/plugged/* && echo "[-] plugged removed from vim"
    rm -f links/links.his links/bookmarks.html links/cookies.txt && echo "[-] links garbage removed from links"
}

# backup function using philosofy l4ycode
backup()
{
    copytool="rsync -rv"
    echo "[LOG] backup init" >> ./backup/log.txt
    [[ -d ~/.zsh ]] && {
        $copytool ~/.zsh/ ./backup/zsh &&
        echo "[LOG] ~/.zsh backup in ./backup/zsh" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.zsh backup failed to ./backup/zsh (no exists)" >> ./backup/log.txt
    }
    [[ -d ~/.config ]] && {
        $copytool --exclude="mozilla*" ~/.config ./backup/config &&
        echo "[LOG] ~/.config backup in ./backup/config/" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.config backup failed to ./backup/config (no exists)" >> ./backup/log.txt
    }
    [[ -d ~/.vim ]] && {
        $copytool ~/.vim/ ./backup/vim &&
        echo "[LOG] ~/.vim backup in ./backup/vim" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.vim backup failed in ./backup/vim (no exists)" >> ./backup/log.txt
    }
    [[ -f ~/.vimrc ]] && {
        $copytool ~/.vimrc ./backup/vimrc &&
        echo "[LOG] ~/.vimrc backup in ./backup/vimrc" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.vimrc backup in ./backup/vimrc failed (no exists)" >> ./backup/log.txt
    }
    [[ -d ~/.links ]] && {
        $copytool ~/.links/ ./backup/links &&
        echo "[LOG] ~/.links backup in ./backup/links" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.links backup in ./backup/links failed (no exists)" >> ./backup/log.txt
    }
    [[ -f ~/.tmux.conf ]] && {
        $copytool ~/.tmux.conf ./backup/tmux.conf &&
        echo "[LOG] ~/.tmux.conf backup in ./backup/tmux.conf" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.tmux.conf backup in ./backup/tmux.conf failed (no exists)" >> ./backup/log.txt
    }
    [[ -d ~/.tmux ]] && {
        $copytool ~/.tmux/ ./backup/tmux &&
        echo "[LOG] ~/.tmux backup in ./backup/tmux" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.tmux backup in ./backup/tmux failed (no exists)" >> ./backup/log.txt
    }
    [[ -d ~/.local/bin ]] && {
        $copytool ~/.local/bin/ ./backup/bin &&
        echo "[LOG] ~/.local/bin backup in ./backup/bin" >> ./backup/log.txt
    } || {
        echo "[ERR] ~/.local/bin backup in ./backup/bin failed (no exists)" >> ./backup/log.txt
    }
    echo "[LOG] backup end" >> ./backup/log.txt
}

case $1 in
    b)
        backup;;
    *)
        all
        pos
esac
