function colors
    for i in (seq 1 255)
        printf "\x1b[38;5;%sm  $(tput sgr0)%s\n" $i $i
    end
end
