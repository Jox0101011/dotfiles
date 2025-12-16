if status --is-command-substitution
    return
end

function _autopair_tab
    commandline --paging-mode && down-or-search && return

    string match --quiet --regex -- '\$[^\s]*"$' (commandline --current-token) &&
        commandline --function end-of-line --function backward-delete-char
    commandline --function complete
end
