complete -c mdk4 -l help       -d "Show help"
complete -c mdk4 -l fullhelp   -d "Show all attack help"
complete -c mdk4 -l version    -d "Show version"

complete -c mdk4 -f -n "__fish_use_subcommand" -a "(ifconfig | awk '/^[a-zA-Z0-9]+/{print \$1}')" -d "Network interface"

set -l mdk4_modes b a p d m e s w f x
complete -c mdk4 -n "not __fish_seen_subcommand_from $mdk4_modes" \
    -a "$mdk4_modes" -d "Attack mode"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s n -d "SSID personalizado" -r
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s a -d "Caracteres não-printáveis"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s f -d "Lista de SSIDs" -r -F
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s v -d "MAC+SSID list" -r -F
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s t -d "Modo Ad-Hoc/Managed (0/1)" -a "0 1"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s w -d "Tipo de criptografia" -a "n w t a"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s b -d "Bitrate" -a "b g"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s m -d "MAC válida (OUI)"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s h -d "Channel hopping"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s c -d "Canal" -a "(seq 1 14)"
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s i -d "IE hexadecimal" -r
complete -c mdk4 -n "__fish_seen_subcommand_from b" -s s -d "PPS (default 50)" -r
complete -c mdk4 -n "__fish_seen_subcommand_from a" -s a -d "AP alvo (MAC)" -r
complete -c mdk4 -n "__fish_seen_subcommand_from a" -s m -d "MAC válida (OUI)"
complete -c mdk4 -n "__fish_seen_subcommand_from a" -s i -d "Modo inteligente (AP)" -r
complete -c mdk4 -n "__fish_seen_subcommand_from a" -s s -d "PPS (default unlimited)" -r

complete -c mdk4 -n "__fish_seen_subcommand_from p" -s e -d "SSID alvo" -r
complete -c mdk4 -n "__fish_seen_subcommand_from p" -s f -d "Arquivo de SSIDs" -r -F
complete -c mdk4 -n "__fish_seen_subcommand_from p" -s t -d "MAC do AP alvo" -r
complete -c mdk4 -n "__fish_seen_subcommand_from p" -s s -d "PPS (default 400)" -r
complete -c mdk4 -n "__fish_seen_subcommand_from p" -s b -d "Charset" -a "n u l s"
complete -c mdk4 -n "__fish_seen_subcommand_from p" -s p -d "Continuar BF a partir de <word>" -r
complete -c mdk4 -n "__fish_seen_subcommand_from p" -s r -d "Canal" -a "(seq 1 14)"

complete -c mdk4 -n "__fish_seen_subcommand_from d" -s w -d "Whitelist file" -r -F
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s b -d "Blacklist file" -r -F
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s s -d "PPS" -r
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s x -d "Full IDS stealth"
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s c -d "Channel hopping" -a "(seq 1 14)"
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s E -d "ESSID alvo" -r
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s B -d "BSSID alvo" -r
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s S -d "MAC da estação" -r
complete -c mdk4 -n "__fish_seen_subcommand_from d" -s W -d "Whitelist Station MAC" -r

complete -c mdk4 -n "__fish_seen_subcommand_from x" -s s -d "PPS"
complete -c mdk4 -n "__fish_seen_subcommand_from x" -s c -d "Channel hopping" -a "(seq 1 14)"
complete -c mdk4 -n "__fish_seen_subcommand_from x" -s v -d "Vendor PoC file" -r
complete -c mdk4 -n "__fish_seen_subcommand_from x" -s B -d "AP MAC" -r
complete -c mdk4 -n "__fish_seen_subcommand_from x" -s S -d "Source MAC" -r
complete -c mdk4 -n "__fish_seen_subcommand_from x" -s T -d "Target MAC" -r

