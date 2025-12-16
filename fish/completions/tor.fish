function __tor_last_token
    commandline -opc | tail -1
end

complete -c tor -s h -l help -d "Mostrar ajuda"
complete -c tor -s f -l torrc-file -r -d "Arquivo de configuração"
complete -c tor -l allow-missing-torrc -d "Permitir torrc ausente"
complete -c tor -l defaults-torrc -r -d "Arquivo torrc-defaults"
complete -c tor -l ignore-missing-torrc -d "Tratar torrc ausente como vazio"

complete -c tor -l hash-password -r -d "Gerar senha hash para control port"

complete -c tor -l list-fingerprint -d "Gerar fingerprint"
complete -c tor -n "__fish_seen_argument --list-fingerprint" \
    -a "rsa ed25519" \
    -d "Tipo de chave"

complete -c tor -l verify-config -d "Verifica o torrc"

complete -c tor -l dump-config -d "Dump de configurações"
complete -c tor -n "__fish_seen_argument --dump-config" \
    -a "short full" \
    -d "Nível de detalhamento"

complete -c tor -l service -d "Gerenciar serviço Windows"
complete -c tor -n "__fish_seen_argument --service" \
    -a "install remove start stop" \
    -d "Ação do serviço"
complete -c tor -n "__fish_seen_argument --service; and test (__tor_last_token) = install" \
    -a "--options" \
    -d "Passar opções para o serviço"
complete -c tor -l nt-service -d "Interno para serviço Windows"
complete -c tor -l list-torrc-options -d "Lista todas opções"
complete -c tor -l list-deprecated-options -d "Lista opções obsoletas"
complete -c tor -l list-modules -d "Lista módulos compilados"
complete -c tor -l version -d "Mostrar versão"
complete -c tor -l quiet -d "Não logar no console"
complete -c tor -l hush -d "Logar apenas avisos/erros"
complete -c tor -l keygen -d "Gerar chaves ed25519"
complete -c tor -n "__fish_seen_argument --keygen" \
    -l newpass -d "Adicionar/trocar senha da chave"
complete -c tor -l passphrase-fd -r -d "FD para ler a senha"
complete -c tor -l key-expiration -d "Ver expiração de chave"
complete -c tor -n "__fish_seen_argument --key-expiration" \
    -a "sign" \
    -d "Propósito"
complete -c tor -n "__fish_seen_argument sign" \
    -l format -a "iso8601 timestamp" \
    -d "Formato da data"
complete -c tor -l dbg-... -d "Opções de debug (não estáveis)"
