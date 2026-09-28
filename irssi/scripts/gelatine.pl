use strict;
use warnings;
use utf8;
use Irssi;

our $VERSION = '1.1';
our %IRSSI = (
    authors     => 'lay',
    contact     => '',
    name        => 'gelatine',
    description => 'Recolore nicks, destaca menções ao seu nick e adiciona comandos coloridos personalizados para o irssi.',
    license     => 'GPL',
);

my @DEFAULT_PALETTE = ('%r', '%g', '%y', '%b', '%m', '%c',
                        '%R', '%G', '%Y', '%B', '%M', '%C');

Irssi::settings_add_bool('gelatine', 'cc_nick_colors', 1);
Irssi::settings_add_bool('gelatine', 'cc_highlight_mentions', 1);
Irssi::settings_add_str('gelatine', 'cc_palette', join(',', @DEFAULT_PALETTE));
Irssi::settings_add_str('gelatine', 'cc_mention_color', '%_%R');
Irssi::settings_add_str('gelatine', 'cc_mention_gradient', '13,5,4,6,12,9');
Irssi::settings_add_str('gelatine', 'cc_mention_symbol', '★');

my %nick_color_cache;

my @PASTEL_PALETTE = ([0, 13], [0, 12], [1, 0]);
my @FUN_PALETTE    = ([0, 4], [1, 8], [0, 3], [0, 12], [1, 6], [0, 13]);

sub get_palette {
    my $raw = Irssi::settings_get_str('cc_palette');
    my @p = split(/,/, $raw);
    @p = @DEFAULT_PALETTE unless @p;
    return @p;
}

sub get_nick_color {
    my ($nick) = @_;
    return $nick_color_cache{$nick} if exists $nick_color_cache{$nick};

    my @palette = get_palette();
    my $sum = 0;
    $sum += ord($_) for split //, $nick;
    my $color = $palette[$sum % scalar(@palette)];

    $nick_color_cache{$nick} = $color;
    return $color;
}

sub get_mention_gradient {
    my $raw = Irssi::settings_get_str('cc_mention_gradient');
    my @g = split(/,/, $raw);
    @g = (13, 5, 4, 6, 12, 9) unless @g;
    return @g;
}

# Aplica uma cor mIRC diferente a cada caractere do texto, criando um
# efeito de gradiente, e envolve o resultado com um símbolo UTF.
sub gradient_text {
    my ($text) = @_;
    my @gradient = get_mention_gradient();
    my $symbol   = Irssi::settings_get_str('cc_mention_symbol');
    my @chars = split //, $text;
    my $out = $symbol;
    for my $i (0 .. $#chars) {
        my $code = sprintf('%02d', $gradient[$i % scalar(@gradient)]);
        $out .= "\x03$code$chars[$i]";
    }
    $out .= "\x0f$symbol";
    return $out;
}

sub sig_print_text {
    my ($dest, $text, $stripped) = @_;
    return unless ref $dest;

    my $level = $dest->{level};
    return unless $level & (Irssi::MSGLEVEL_PUBLIC() | Irssi::MSGLEVEL_ACTIONS());

    my $server  = $dest->{server};
    my $ownnick = $server ? $server->{nick} : undef;

    if ($ownnick && Irssi::settings_get_bool('cc_highlight_mentions')
        && $stripped =~ /\Q$ownnick\E/i) {
        $text =~ s/(\Q$ownnick\E)/gradient_text($1)/gei;
    }

    if (Irssi::settings_get_bool('cc_nick_colors')
        && $stripped =~ /^<[\@\+\%]?([^>]+)>/) {
        my $nick  = $1;
        my $color = get_nick_color($nick);
        $text =~ s/(\Q$nick\E)(?=>)/$color$1%n/;
    }

    $_[1] = $text;
}
Irssi::signal_add('print text', 'sig_print_text');

sub colorize_words {
    my ($text, $palette_ref) = @_;
    my @palette = @$palette_ref;
    my @parts = split /(\s+)/, $text;
    my $out = '';
    my $i = 0;
    for my $part (@parts) {
        if ($part =~ /\S/) {
            my ($fg, $bg) = @{ $palette[$i % scalar(@palette)] };
            my $fgcode = sprintf('%02d', $fg);
            my $bgcode = sprintf('%02d', $bg);
            $out .= "\x03$fgcode,$bgcode$part\x0f";
            $i++;
        } else {
            $out .= $part;
        }
    }
    return $out;
}

sub cmd_slap {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+$//;
    my $target = ($data ne '') ? $data : 'o ar';
    my @weapons = (
        'um peixe fresco', 'um teclado mecânico', 'a paciência dos outros',
        'um cabo de rede cat5', 'um pendrive de 128MB', 'um disquete de 3.5"',
    );
    my $weapon = $weapons[int(rand(scalar @weapons))];
    my $colored = colorize_words("► esbofeteia $target com $weapon", \@FUN_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('slap', 'cmd_slap');

sub cmd_roll {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+//g;
    my $sides = ($data =~ /^\d+$/ && $data > 0) ? $data : 6;
    my $result = int(rand($sides)) + 1;
    my $colored = colorize_words("⚅ rola um dado de $sides lados e tira $result", \@FUN_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('roll', 'cmd_roll');

sub cmd_banner {
    my ($data, $server, $witem) = @_;
    return unless $witem && $data ne '';
    my $line = '✦' x (length($data) + 4);
    $witem->command("say " . colorize_words($line, \@FUN_PALETTE));
    $witem->command("say " . colorize_words("✦ $data ✦", \@FUN_PALETTE));
    $witem->command("say " . colorize_words($line, \@FUN_PALETTE));
}
Irssi::command_bind('banner', 'cmd_banner');

sub cmd_note {
    my ($data, $server, $witem) = @_;
    return if $data eq '';
    my $path = Irssi::get_irssi_dir() . '/gelatine_notes.txt';
    if (open(my $fh, '>>:encoding(UTF-8)', $path)) {
        print $fh scalar(localtime()) . " - $data\n";
        close $fh;
        Irssi::print("✎ %G%_Nota salva:%n $data");
    } else {
        Irssi::print("⚠ %R%_não foi possível salvar a nota%n (%_$path%_)");
    }
}
Irssi::command_bind('note', 'cmd_note');

sub cmd_ccreload {
    %nick_color_cache = ();
    Irssi::print("⟳ %Cgelatine%n: %Gcache de cores de nick limpo%n");
}
Irssi::command_bind('ccreload', 'cmd_ccreload');

sub cmd_8ball {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    my @answers = (
        'Sim.', 'Não.', 'Talvez.', 'Pergunte novamente mais tarde.',
        'Com certeza.', 'Duvido muito.', 'As perspectivas não são boas.',
        'Sem dúvida.', 'Concentre-se e pergunte de novo.',
    );
    my $answer = $answers[int(rand(scalar @answers))];
    my $colored = colorize_words("● consulta a bola mágica: $answer", \@FUN_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('8ball', 'cmd_8ball');

sub cmd_coin {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    my $result = (int(rand(2)) == 0) ? 'cara' : 'coroa';
    my $colored = colorize_words("◎ joga uma moeda para o alto... $result!", \@FUN_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('coin', 'cmd_coin');

sub cmd_hug {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+$//;
    my $target = ($data ne '') ? $data : 'todo mundo';
    my $colored = colorize_words("♥ abraça $target bem apertado", \@PASTEL_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('hug', 'cmd_hug');

sub cmd_kiss {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+$//;
    my $target = ($data ne '') ? $data : 'o ar';
    my $colored = colorize_words("✿ dá um beijo em $target", \@PASTEL_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('kiss', 'cmd_kiss');

sub cmd_rainbow {
    my ($data, $server, $witem) = @_;
    return unless $witem && $data ne '';
    my @colors = (4, 7, 8, 3, 12, 2, 6, 13);
    my $out = '';
    my $i = 0;
    for my $ch (split //, $data) {
        if ($ch =~ /\S/) {
            my $code = sprintf('%02d', $colors[$i % scalar(@colors)]);
            $out .= "\x03$code$ch";
            $i++;
        } else {
            $out .= $ch;
        }
    }
    $out .= "\x0f";
    $witem->command("say ☼ $out");
}
Irssi::command_bind('rainbow', 'cmd_rainbow');

sub cmd_whoami {
    my ($data, $server, $witem) = @_;
    my $nick = $server ? $server->{nick} : '?';
    my $netw = $server ? $server->{tag} : '?';
    my $chan = ($witem && $witem->{name}) ? $witem->{name} : '-';
    Irssi::print("☺ %C%_gelatine%_%n: %Ynick%n=$nick %Yrede%n=$netw %Yjanela%n=$chan");
}
Irssi::command_bind('whoami', 'cmd_whoami');

sub cmd_poke {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+$//;
    my $target = ($data ne '') ? $data : 'alguém';
    my $colored = colorize_words("✦ cutuca $target", \@FUN_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('poke', 'cmd_poke');

sub cmd_highfive {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+$//;
    my $target = ($data ne '') ? $data : 'todo mundo';
    my $colored = colorize_words("► bate um high-five em $target", \@FUN_PALETTE);
    $witem->command("me $colored");
}
Irssi::command_bind('highfive', 'cmd_highfive');

sub cmd_shrug {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+$//;
    my $msg = ($data ne '') ? "$data ¯\\_(ツ)_/¯" : "¯\\_(ツ)_/¯";
    $witem->command("say " . colorize_words($msg, \@PASTEL_PALETTE));
}
Irssi::command_bind('shrug', 'cmd_shrug');

sub cmd_flip {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+$//;
    my $msg = ($data ne '') ? "$data (╯°□°)╯︵ ┻━┻" : "(╯°□°)╯︵ ┻━┻";
    $witem->command("say " . colorize_words($msg, \@FUN_PALETTE));
}
Irssi::command_bind('flip', 'cmd_flip');

sub cmd_unflip {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $witem->command("say " . colorize_words("┬─┬ ノ( ゜-゜ノ)", \@PASTEL_PALETTE));
}
Irssi::command_bind('unflip', 'cmd_unflip');

my @FORTUNES = (
    'Um bug hoje é uma feature amanhã.',
    'Boas coisas vêm para quem compila sem erros.',
    'O código escrito às 3h da manhã vai te assombrar.',
    'Hoje é um bom dia para dar commit.',
    'Cuidado com off-by-one errors no seu futuro.',
    'Você vai encontrar aquele bug procurado há semanas.',
    'Um café puxado resolve a maioria dos seus problemas hoje.',
    'Evite fazer deploy numa sexta-feira.',
    'Alguém vai perguntar "funciona na sua máquina?" hoje.',
);

sub cmd_fortune {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    my $f = $FORTUNES[int(rand(scalar @FORTUNES))];
    my $colored = colorize_words("● $f", \@FUN_PALETTE);
    $witem->command("say $colored");
}
Irssi::command_bind('fortune', 'cmd_fortune');

sub cmd_quote {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    my $path = Irssi::get_irssi_dir() . '/gelatine_notes.txt';
    unless (-e $path) {
        Irssi::print("⚠ nenhuma nota salva ainda (use /note)");
        return;
    }
    open(my $fh, '<:encoding(UTF-8)', $path) or return;
    my @lines = <$fh>;
    close $fh;
    chomp @lines;
    @lines = grep { /\S/ } @lines;
    unless (@lines) {
        Irssi::print("⚠ nenhuma nota salva ainda (use /note)");
        return;
    }
    my $line = $lines[int(rand(scalar @lines))];
    $witem->command("say " . colorize_words("✎ $line", \@PASTEL_PALETTE));
}
Irssi::command_bind('quote', 'cmd_quote');

sub countdown_step {
    my ($args) = @_;
    my ($witem, $n) = @$args;
    if ($n > 0) {
        $witem->command("say " . colorize_words("$n...", \@FUN_PALETTE));
        Irssi::timeout_add_once(1000, \&countdown_step, [$witem, $n - 1]);
    } else {
        $witem->command("say " . colorize_words("► já foi!", \@FUN_PALETTE));
    }
}

sub cmd_countdown {
    my ($data, $server, $witem) = @_;
    return unless $witem;
    $data =~ s/\s+//g;
    my $n = ($data =~ /^\d+$/ && $data > 0 && $data <= 20) ? $data : 5;
    countdown_step([$witem, $n]);
}
Irssi::command_bind('countdown', 'cmd_countdown');

Irssi::print("✦ %_%Cgelatine%n carregado. Comandos: /slap, /roll, /banner, /note, /ccreload, /8ball, /coin, /hug, /kiss, /rainbow, /whoami, /poke, /highfive, /shrug, /flip, /unflip, /fortune, /quote, /countdown. Configurações: /set cc_nick_colors, /set cc_highlight_mentions, /set cc_palette, /set cc_mention_color, /set cc_mention_gradient, /set cc_mention_symbol");
