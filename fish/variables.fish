fish_vi_key_bindings

set -g fish_greeting ''
set -gx EDITOR vim
set -gx VISUAL vim
set -gx PAGER less
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
#set -gx FZF_DEFAULT_OPTS "--height=40% --layout=reverse --border --color=bg+:#1d2021,bg:#282828,spinner:#d79921,hl:#fabd2f,fg:#ebdbb2,header:#fabd2f,info:#b8bb26,pointer:#fe8019,marker:#b8bb26,fg+:#fbf1c7,prompt:#d79921,hl+:#fabd2f"
set ABBR_TIPS_PROMPT "\ntip: \e[1m{{ .abbr }}\e[0m => {{ .cmd }}"
set PATH /home/hazer/.local/bin /home/hazer/.cargo/bin /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /var/lib/flatpak/exports/bin /usr/lib/jvm/default/bin /usr/bin/site_perl /usr/bin/vendor_perl /usr/bin/core_perl /home/hazer/.local/share/gem/ruby/3.4.0/bin/



alias cd='z'
alias ls='eza'
alias ll='ls -l'
alias la='ls -a'
