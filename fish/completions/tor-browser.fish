function __torbrowser__complete
    complete -c tor-browser -s h -l help -d "Show help"
    complete -c tor-browser -s u -l update -d "Search in AUR for a new release and install it"
    complete -c tor-browser -s r -l refresh -d "Refresh the copy in your home directory($(echo "$HOME")) and launch tor-browser"
    complete -c tor-browser -s e -l erase -d "Erase the copy in your home directory($(echo  "$HOME"))"
    complete -c tor-browser -l dir -d "The Tor-Browser directory to use"
end

__torbrowser__complete
