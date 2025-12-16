# ===========================================================
# TLDR completions para Fish
# ===========================================================

# Função para listar todas as páginas do TLDR
function __tldr_pages
    # se tiver cache local
    if test -d ~/.tldr
        find ~/.tldr -type f -name '*.md' | sed 's|.*/\([^/]*\)\.md$|\1|' | sort -u
    else
        # fallback simples se não existir cache
        tldr --list 2>/dev/null
    end
end

# Completions para comandos
complete -c tldr -f -a "(__tldr_pages)" -d "TLDR page"

# Completions para flags principais
complete -c tldr -l update -d "Update local TLDR pages"
complete -c tldr -l list -d "List all available pages"
complete -c tldr -l help -d "Show help"
complete -c tldr -l version -d "Show version"

# Completions para plataformas
complete -c tldr -l platform -a "common linux osx sunos windows" -d "Platform"

