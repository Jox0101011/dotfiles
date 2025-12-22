# LISH | Life in Shell

esta parte do meu repositorio eu vou explicar algumas coisas + com um dotfiles novo especifico para você ficar apenas com o terminal aberto, mais abaixo vou deixar um Guia!


1. Instale kitty (emulador de terminal)
---

> Oque é um emulador de terminal?

---

nesse caso em especifico vou usar algo mais grafico para demostrar:
  
[emulador de terminal] -> [shell] -> [multiplexador de terminal] 

---


2. Instale zsh (shell)

---

> Oque é um shell?

---

é uma interface que casualmente é usado para mexer no sistema de melhor forma. nesse caso o z shell é um substituto ao bash(bourne again shell)

---



3. Instale tmux (multiplexador de terminal)
---

> Oque é um multiplexador de terminal?

---

é como um terminal, porém sem necessariamente precisar de um emulador de terminal como kitty para ser executado, pois ele usa o proprio shell, as vantagens são muitas, mas as que você vai focar vai ser basicamente os comandos como:
```
prefix=CTRL + B
prefix + %     ; cria um split vertical
prefix + "     ; cria um split horizontal
prefix + ,     ; essa keybind vai renomear a sua janela
prefix + s     ; abre o seletor de janelas
prefix + 0-9   ; troca de workspace
prefix + setas ; troca de split rapidamente
prefix + x     ; fecha uma split/janela

prefix + $     ; renomea a sessão
```

## Aviso: não leve isso como um estudo real, se aprofunde em tudo que eu falar aqui, para não haver duvidas, isso é apenas um resumo
---

Após fazer isso, agora vamos a parte mais interessante..

## Programas !
alguns eu ja falei como:

- zsh
- tmux
- kitty

porém precisamos de algo a mais :)

### Process Managers

- htop(recomendado)
- top
- btop
- bashtop
- nvtop
- ps(com aux)

---

### Shell's

- bash
- fish
- zsh(recomendado)
- mksh

---

### File Managers

- lf
- nnn
- ranger
- vifm

---

### Editores de textos

- vim(menção honrosa como o melhor)
- nvim
- micro
- helix
- emacs
- nano

### TUI Creators

- gum
- dialog
- whiptail
- tput

### Navegadores

- carbonyl(aceita JS)
- links
- elinks
- lynx
- browsh(aceita JS)
- w3m
- ddgr(unico CLI da lista(por ser mais uma search engine pura de terminal))

### Proxy's

- proxychains
- openvpn
- torsocks(ta eu sei ele não é exatamente um proxy)

### Alguns CLI extras

- cowsay
- figlet
- toilet
- lolcat
- sl
- feh

### Para os Ricers

- asciiquarium
- fastfetch
- pfetch
- ufetch
- zathura(não é cli btw, caso queira algo cli use glow e transforma o pdf em markdown por alguma tool)
- cava

### Leitores de arquivos

- lost(menção honrosa a minha tool (: )
- most
- bat
- less
- more

### Learning

- man
- tldr
- wtf
- bro
- apropos

### IA / LLM

- aichat
- tgpt

### IRC e Outros chats de conversa

- irssi
- weechat
- hexchat
- discordo

### Redes

- tcpdump
- termshark
- tshark
- ip && iw
---

### Visualizadores de imagem e video / Tocadores de audio

- chafa
- kitten +icat
- mpv
---
