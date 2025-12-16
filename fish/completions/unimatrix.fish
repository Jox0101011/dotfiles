complete -c unimatrix -s a -l asynchronous      -d "Scroll assíncrono"
complete -c unimatrix -s b -l all-bold          -d "Só bold"
complete -c unimatrix -s n -l no-bold           -d "Sem bold"
complete -c unimatrix -s c -l color             -d "Cor do texto"        -r
complete -c unimatrix -s g -l bg-color          -d "Cor do fundo"        -r
complete -c unimatrix -s f -l flashers          -d "Flashers"
complete -c unimatrix -s o -l status-off        -d "Sem status"
complete -c unimatrix -s i -l ignore-keyboard   -d "Ignora teclado"
complete -c unimatrix -s s -l speed             -d "Velocidade"          -r
complete -c unimatrix -s t -l time              -d "Tempo limite"        -r
complete -c unimatrix -s u -l custom-characters -d "Caracteres custom"   -r
complete -c unimatrix -s l -l character-list    -d "Character sets"      -r
complete -c unimatrix -s w -l single-wave       -d "Modo single-wave"
complete -c unimatrix -s h -l help              -d "Ajuda"

set -l sets a A c C e g G k m n o p P r R s S u

complete -c unimatrix -n "__fish_seen_argument -l character-list" -a "$sets" -d "Character set"

