if status is-interactive
    and not functions -q fisher
    source ~/.config/fish/functions/fisher.fish
end

fish_vi_key_bindings

set -g fish_greeting ''
set -gx EDITOR vim
set -gx VISUAL vim
set -gx PAGER less
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border --color=bg+:#1d2021,bg:#282828,spinner:#d79921,hl:#fabd2f,fg:#ebdbb2,header:#fabd2f,info:#b8bb26,pointer:#fe8019,marker:#b8bb26,fg+:#fbf1c7,prompt:#d79921,hl+:#fabd2f"

alias cd='z'
alias l='ls'
alias ls='eza'
alias ll='ls -lh'
alias la='ls -a'
alias lla='ls -lha'

zoxide init fish | source
starship init fish | source

if status is-interactive
    if not set -q TMUX
        tmux attach -t main 2>/dev/null; or tmux new -s main
    end
end
