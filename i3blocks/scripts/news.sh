#!/usr/bin/env bash

CONFIG_FILE="$HOME/.newsfeeds.json"

for cmd in curl xmllint fzf xdg-open jq; do
    command -v $cmd >/dev/null 2>&1 || { echo "Instale $cmd"; exit 1; }
done

declare -A FEEDS
while IFS="=" read -r category urls; do
    FEEDS["$category"]="$urls"
done < <(jq -r 'to_entries|map("\(.key)=\(.value|join(","))")|.[]' "$CONFIG_FILE")

echo "Categorias:"
select CAT in "${!FEEDS[@]}"; do
    [ -n "$CAT" ] || exit
    break
done

IFS=',' read -r -a URLS <<< "${FEEDS[$CAT]}"

ARTICLES=()
for url in "${URLS[@]}"; do
    DATA=$(curl -s "$url")
    TITLES=$(echo "$DATA" | xmllint --xpath "//item/title/text()" - 2>/dev/null)
    LINKS=$(echo "$DATA" | xmllint --xpath "//item/link/text()" - 2>/dev/null)
    IFS=$'\n'
    read -r -a TITLES <<< "$TITLES"
    read -r -a LINKS <<< "$LINKS"
    for i in "${!TITLES[@]}"; do
        ARTICLES+=("${TITLES[i]}:::${LINKS[i]}")
    done
done

CHOICE=$(printf "%s\n" "${ARTICLES[@]}" | fzf --prompt="Escolha uma notícia: " --ansi)

if [ -n "$CHOICE" ]; then
    LINK="${CHOICE##*:::}"
    xdg-open "$LINK"
fi

