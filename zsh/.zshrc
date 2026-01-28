HISTFILE="$HOME/.zsh_history"
if [ -d "$HISTFILE" ]; then
    continue
else
    touch "$HISTFILE"
    chmod 600 "$HISTFILE"
fi

HISTSIZE="10000"
SAVEHIST="10000"

setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt EXTENDED_HISTORY

[[ -o interactive ]] || return

setopt extendedglob
setopt globstarshort

zmodload zsh/net/tcp

autoload -U colors && colors
setopt PROMPT_SUBST

exit_code()
{
  ec=$?
  [[ ec -ne 0 ]] && echo "%B%F{red}$ec%f%b "
}

autoload -U colors && colors
PS1='%F{white}[%f$(exit_code)%F{cyan}%n%f@%F{yellow}%m%f%F{blue} %~%f%F{white}]%f %# '

if command -v zoxide >/dev/null; then
  eval "$(zoxide init zsh)"
fi

if [[ -z "$TMUX" ]]; then
  tmux attach -t main 2>/dev/null || tmux new -s main
fi

export MANLANG=pt_BR.UTF-8
export EDITOR=vim
export VISUAL=vim
export PAGER=less

export PATH="
/home/hzr/.local/bin
/home/hzr/.cargo/bin
/usr/local/sbin
/usr/local/bin
/usr/sbin
/usr/bin
/sbin
/bin
/var/lib/flatpak/exports/bin
/usr/lib/jvm/default/bin
/usr/bin/site_perl
/usr/bin/vendor_perl
/usr/bin/core_perl
/home/hzr/.local/share/gem/ruby/3.4.0/bin
:$PATH"

autoload -Uz compinit
compinit

bindkey -v
export KEYTIMEOUT=1

if [[ ! -f ~/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  mkdir -p ~/.local/share/zinit
  git clone https://github.com/zdharma-continuum/zinit.git \
    ~/.local/share/zinit/zinit.git
fi

if [ ! -d ".zsh_completions" ]; then
    mkdir -p .zsh_completion 2>/dev/null
    echo "# this completion is a test please ignore :3" | tee .zsh_completion/example &>/dev/null
    else
        source $HOME/.zsh_completions/* 2>/dev/null
fi

source ~/.local/share/zinit/zinit.git/zinit.zsh

zinit light lukechilds/zsh-nvm
zinit light junegunn/fzf
zinit light hlissner/zsh-autopair
zinit light wfxr/forgit
zinit light momo-lab/zsh-abbrev-alias
zinit light ael-code/zsh-colored-man-pages
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

alias cd='cd'
alias ls='ls --color'
alias la='ls -a'
alias ll='ls -l'
alias grep='grep --color'
alias bcat='bat --style=plain --paging=never --theme=gruvbox-dark'
alias vi='vim'
