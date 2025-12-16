#!/usr/bin/env bash
set -e

REPO_URL="https://github.com/Jox0101011/dotfiles.git"
DOTFILES_DIR="$HOME/.dotfiles"

# Verifica se dialog/whiptail existe
if ! command -v dialog &>/dev/null && ! command -v whiptail &>/dev/null; then
  echo "dialog/whiptail não instalado. Instalando (no Arch):"
  sudo pacman -S --noconfirm dialog || true
fi

DLG=$(command -v whiptail &>/dev/null && echo "whiptail" || echo "dialog")

# Clona ou atualiza o repo
if [ -d "$DOTFILES_DIR" ]; then
  cd "$DOTFILES_DIR"
  git pull
else
  git clone "$REPO_URL" "$DOTFILES_DIR"
fi

# Monta checklist com os sub-diretórios (seu layout de modules: i3, vim, tmux, etc)
OPTIONS=()
for d in "$DOTFILES_DIR"/*; do
  base=$(basename "$d")
  # ignora README e arquivos irrelevantes
  if [ -d "$d" ] && [[ "$base" != ".git" ]]; then
    OPTIONS+=("$base" "$base config" "OFF")
  fi
done

CHOICES=$($DLG --checklist "Selecione os módulos para ativar:" 20 70 15 \
  "${OPTIONS[@]}" 3>&1 1>&2 2>&3)

# Função para linkar dots
link_dotfile() {
  src="$1"
  dest="$HOME/$2"
  mkdir -p "$(dirname "$dest")"
  ln -sf "$src" "$dest"
  echo "Linked $src → $dest"
}

# Itera sobre escolhas
for module in $CHOICES; do
  # remove aspas se existirem
  module=$(echo "$module" | tr -d '"')
  src_dir="$DOTFILES_DIR/$module"
  # para cada arquivo/dir oculto dentro do módulo, linka pra $HOME mantendo estrutura
  find "$src_dir" -maxdepth 2 \( -type f -or -type d \) | while read -r f; do
    rel="${f#$src_dir/}"
    link_dotfile "$f" "$rel"
  done
done

echo "Instalação concluída. Recarga seu shell."
