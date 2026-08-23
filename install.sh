#!/usr/bin/env bash
lga="./log.txt" # lga=log archive

_log()
{
    printf "[LOG] $@\n">>$lga
}

_err()
{
    printf "[ERR] $@\n">>$lga
}

mkdot()
{
    echo "[LOG] removing files"
    FILES=("~/.local/bin", "~/.zsh", "~/.config/dunst", "~/.config/fastfetch", "~/.config/kitty", "~/.config/i3", "~/.config/i3blocks", "~/.links", "~/.config/htop", "~/.zshrc")
    for i in "${FILES[@]}"; do
        rm -ri "$i" && { _log "$i removed"
        } || { _err "$i remove failed"; }
    done && _log "removing files sucess" || echo "[ERR] removing files failed"
    mv ./dunst ~/.config/dunst && _log "add dunst to u system"
    mv ./htop ~/.config/htop && _log "add htop to u system"
    mv ./endcord ~/.config/endcord && _log "add endcord to u system"
    mv ./links ~/.links && _log "add links to u system"
    mv ./vim/vimrc ~/.vimrc && _log "add vimrc to u system"
    mv ./vim/vim ~/.vim && _log "add vim to u system"
    mv ./fastfetch ~/.config/fastfetch && _log "add fastfetch to u system"
    mv ./kitty ~/.config/kitty && _log "add kitty to u system"
    mv ./zsh/zshrc ~/.zshrc && _log "add zshrc to u system"
    mv ./zsh/zsh ~/.zsh && _log "add zsh to u system"
    mv ./i3 ~/.config/i3 && _log "add i3 to u system"
    mv ./i3blocks ~/.config/i3blocks && _log "add i3blocks to u system"
    mv ./dmenu ~/.local/bin && _log "add dmenu to u system"
}

main()
{
    if [[ -f ./automakedot.sh ]]; then
        mkdir -p ./backup
        touch ./backup/log.txt
        ./automakedot.sh b
        _log "Making backup in ./backup: sucess"
        mkdot
    else
        _err "Making backup in ./backup: ./automakedot.sh (no exists)"
        read -n1 -p "continue? [y/N] " pr
        case pr in
            *)
                exit 1 ;;
            y|Y)
                mkdot ;;
        esac
    fi
}

main
