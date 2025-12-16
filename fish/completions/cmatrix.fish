# ==========================
# Flags simples (sem argumentos)
# ==========================

complete -c cmatrix -s a -d "Asynchronous scroll"
complete -c cmatrix -s b -d "Bold characters"
complete -c cmatrix -s B -d "All characters bold"
complete -c cmatrix -s c -d "Japanese characters mode"
complete -c cmatrix -s f -d "Force TERM type"
complete -c cmatrix -s l -d "Linux mode (console font)"
complete -c cmatrix -s L -d "Lock mode"
complete -c cmatrix -s o -d "Old-style scrolling"
complete -c cmatrix -s h -d "Show usage"
complete -c cmatrix -s n -d "Disable bold text"
complete -c cmatrix -s s -d "Screensaver mode"
complete -c cmatrix -s x -d "X-window mode (mtx.pcf)"
complete -c cmatrix -s V -d "Show version"
complete -c cmatrix -s r -d "Rainbow mode"
complete -c cmatrix -s m -d "Lambda mode"

# ==========================
# Flags com argumento
# ==========================

# -u DELAY
complete -c cmatrix -s u -d "Update delay (0-10)" -a "0 1 2 3 4 5 6 7 8 9 10"

# -C COLOR
# Cores conhecidas pelo cmatrix
set -l cmatrix_colors green red blue cyan yellow magenta white black

complete -c cmatrix -s C -d "Matrix color" -a "$cmatrix_colors"

