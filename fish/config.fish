#   m""    "           #                                    m""
# mm#mm  mmm     mmm   # mm           mmm    mmm   m mm   mm#mm
#   #      #    #   "  #"  #         #"  "  #" "#  #"  #    #
#   #      #     """m  #   #         #      #   #  #   #    #
#   #    mm#mm  "mmm"  #   #         "#mm"  "#m#"  #   #    # by hzr


if status is-interactive
    and not functions -q fisher
    source ~/.config/fish/functions/fisher.fish
end

zoxide init fish | source
starship init fish | source

if status is-interactive
    if not set -q TMUX
        fastfetch --config examples/9.jsonc
        echo -e "\e[1;38;5;129mEntrando no TMUX...\e[0m"
        tmux attach -t main 2>/dev/null; or tmux new -s main
    end
end

source ~/.config/fish/variables.fish
