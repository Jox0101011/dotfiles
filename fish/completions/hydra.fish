set -l hydra_flags \
"-R|Restore previous session" \
"-I|Ignore existing restore file" \
"-S|Use SSL connect" \
"-s|Port (override default)" \
"-l|Single login" \
"-L|Login list file" \
"-p|Single password" \
"-P|Password list file" \
"-x|Bruteforce generator MIN:MAX:CHARSET" \
"-y|Disable symbols in bruteforce" \
"-r|Use non-random shuffle for -x" \
"-e|Try null/loginpass/reversed" \
"-u|Loop users, not passwords" \
"-C|Login:pass combo file" \
"-M|Target list file" \
"-o|Output file" \
"-b|Output format text/json/jsonv1" \
"-f|Exit when found (per host)" \
"-F|Exit when found globally (-M)" \
"-t|Parallel tasks per target" \
"-T|Global parallel tasks" \
"-w|Response wait time" \
"-W|Delay between connects" \
"-c|Global wait per login attempt" \
"-4|Use IPv4" \
"-6|Use IPv6" \
"-v|Verbose" \
"-V|Show login+pass attempts" \
"-d|Debug mode" \
"-O|Old SSL v2/v3" \
"-K|Do not redo failed attempts" \
"-q|Quiet (ignore connection errors)" \
"-U|List module usage info" \
"-m|Module-specific option" \
"-h|Help"

for entry in $hydra_flags
    set -l flag (string split '|' $entry)[1]
    set -l desc (string split '|' $entry)[2]
    set -l short (string replace '-' '' $flag)
    complete -c hydra -s $short -d "$desc"
end

complete -c hydra -l restore -d "Restore previous session"
complete -c hydra -l ipv4    -d "Force IPv4"
complete -c hydra -l ipv6    -d "Force IPv6"

complete -c hydra -s L -r -d "Login list file"     -a "(ls)"
complete -c hydra -s P -r -d "Password list file"  -a "(ls)"
complete -c hydra -s C -r -d "Combo login:pass"    -a "(ls)"
complete -c hydra -s M -r -d "Targets list file"   -a "(ls)"
complete -c hydra -s o -r -d "Output file"

set -l hydra_services \
    adam6500 asterisk afp cisco cisco-enable cobaltstrike cvs firebird \
    ftp ftps http https http-get http-post http-head \
    https-get https-post http-form https-form \
    http-proxy http-proxy-urlenum icq imap imaps irc ldap2 ldap2s \
    ldap3 ldap3s ldap3-crammd5 ldap3-digestmd5 \
    memcached mongodb mssql mysql nntp oracle-listener oracle-sid \
    pcanywhere pcnfs pop3 pop3s postgres radmin2 rdp redis \
    rexec rlogin rpcap rsh rtsp s7-300 sip smb smtp smtps smtp-enum \
    snmp socks5 ssh sshkey svn teamspeak telnet telnetd vmauthd vnc xmpp

complete -c hydra \
    -n "not __fish_seen_subcommand_from $hydra_services" \
    -a "$hydra_services" \
    -d "Hydra service"
function __hydra_targets
    printf "%s\n" \
        "ssh://host" \
        "ftp://host" \
        "http://host" \
        "https://host" \
        "smb://host" \
        "rdp://host"
end

complete -c hydra -a "(__hydra_targets)" -d "Target URL"

