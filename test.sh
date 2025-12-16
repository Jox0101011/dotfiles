    OPTIONS+=("$base" "$base config" "OFF")
  fi
done

CHOICES=$($DLG --checklist "Selecione os módulos para ativar:" 20 70 15 \
  "${OPTIONS[@]}" 3>&1 1>&2 2>&3)

# Função para linkar dots
link_dotfile() {
  src="$1"
  dest="$HOME/$2"
