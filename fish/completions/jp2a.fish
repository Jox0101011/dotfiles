function __jp2a_complete
    complete -c jp2a -a "-" -d "Read images from standard input"

    complete -c jp2a -l blue -d "Grayscale weight (default 0.1145)"
    complete -c jp2a -s b -l border -d "Print border around output"
    complete -c jp2a -l chars -d "Character palette (min 2 chars)"
    complete -c jp2a -l clear -d "Clear screen before each output"
    complete -c jp2a -l colors -d "Use truecolor or ANSI"
    complete -c jp2a -l color-depth -d "Color depth: 4, 8, or 24"

    complete -c jp2a -s d -l debug -d "Debug output"
    complete -c jp2a -l edge-threshold -d "Threshold for edge glyph shading"
    complete -c jp2a -l edges-only -d "Draw only edges"
    complete -c jp2a -l fill -d "Fill char background (HTML or color modes)"

    complete -c jp2a -s x -l flipx -d "Flip horizontally"
    complete -c jp2a -s y -l flipy -d "Flip vertically"

    complete -c jp2a -s f -l term-fit -d "Fit image to terminal aspect ratio"
    complete -c jp2a -l term-height -d "Use terminal height"
    complete -c jp2a -l term-width -d "Use terminal width"
    complete -c jp2a -s z -l term-zoom -d "Zoom to full terminal size"
    complete -c jp2a -s c -l term-center -d "Center in terminal"

    complete -c jp2a -l grayscale -d "Convert to grayscale for HTML/ANSI"
    complete -c jp2a -l green -d "Grayscale weight (default 0.5866)"
    complete -c jp2a -l height -d "Set height (width auto-calculated)"

    complete -c jp2a -s h -l help -d "Show help"

    complete -c jp2a -l htmlls -d "Output HTML Living Standard"
    complete -c jp2a -l html -d "Output strict XHTML 1.0"
    complete -c jp2a -l xhtml -d "Output strict XHTML 1.0"
    complete -c jp2a -l html-fill -d "Alias for --fill"
    complete -c jp2a -l html-fontsize -d "HTML font size (default 4pt)"
    complete -c jp2a -l html-no-bold -d "Disable bold chars in HTML"
    complete -c jp2a -l html-raw -d "Raw HTML (no head, uses <br>)"
    complete -c jp2a -l html-title -d "Set HTML title"

    complete -c jp2a -s i -l invert -d "Invert output"
    complete -c jp2a -l background -xa "dark light" -d "Select background type"

    complete -c jp2a -l output -d "Write output to file"
    complete -c jp2a -l red -d "Grayscale weight (default 0.2989)"
    complete -c jp2a -l size -d "Output size WxH"
    complete -c jp2a -s v -l verbose -d "Verbose output"
    complete -c jp2a -s V -l version -d "Print program version"
    complete -c jp2a -l width -d "Set width (height auto-calculated)"
end

__jp2a_complete

