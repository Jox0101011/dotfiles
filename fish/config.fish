if status is-interactive
    # Commands to run in interactive sessions can go here
alias ls='eza --icons'
alias la='ls -a'
alias ll='ls -lah'
alias le='ls -1'
alias tree='ls --tree'
alias lsd='ls -D'
alias lsf='ls -f'

alias cal='calcurse'

alias gitl='lazygit'
alias cd='z'
alias grep='rg'
alias ping='gping'
alias du='sudo dust'

alias vi='vim'

alias cat='bat'

alias gitstatus='onefetch'

zoxide init fish | source
atuin init fish | source
starship init fish | source

    neofetch
    echo "hello $USER, hack the world!"
    echo ""
    echo ""
end
