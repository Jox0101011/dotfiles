# ~/.config/qutebrowser/config.py
#
# NOTE: config.py é para usuários avançados que preferem editar o
# arquivo manualmente. Também dá pra usar :set/:bind/:config-* sem
# precisar mexer aqui.
#
# Documentação:
#   qute://help/configuring.html
#   qute://help/settings.html

config.load_autoconfig(False)

c.aliases = {
    'q': 'quit',
    'w': 'session-save',
    'wq': 'quit --save',
}

config.bind('<F2>', 'config-cycle tabs.show multiple never')

config.set('colors.webpage.darkmode.enabled', True)

config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

config.set('content.headers.accept_language', '', 'https://matchmaker.krunker.io/*')

config.set(
    'content.headers.user_agent',
    'Mozilla/5.0 ({os_info}; rv:149.0) Gecko/20100101 Firefox/149.0',
    'https://accounts.google.com/*',
)
config.set(
    'content.headers.user_agent',
    'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) '
    '{qt_key}/{qt_version} {upstream_browser_key}/{upstream_browser_version_short} '
    'Safari/{webkit_version}',
    'https://gitlab.gnome.org/*',
)

config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

config.set(
    'content.local_content_can_access_remote_urls',
    True,
    'file:///home/lay/.local/share/qutebrowser/userscripts/*',
)
config.set(
    'content.local_content_can_access_file_urls',
    False,
    'file:///home/lay/.local/share/qutebrowser/userscripts/*',
)

# Paleta:
#   branco base   #FDFBF9   (fundo geral, quase branco quente)
#   azul pastel   #AFCBE8   (destaque principal / modo normal)
#   azul escuro   #6E8FB0   (texto sobre azul claro, bordas)
#   rosa pastel   #F6C9DA   (destaque secundário / insert / seleção)
#   rosa escuro   #C97FA0   (texto sobre rosa, avisos leves)
#   cinza texto   #4A4A4A   (texto principal sobre branco)

c.fonts.default_family = 'GoMono Nerd Font, monospace'
c.fonts.default_size = '10pt'

c.colors.completion.fg = '#4A4A4A'
c.colors.completion.odd.bg = '#FDFBF9'
c.colors.completion.even.bg = '#FBF3F6'
c.colors.completion.category.fg = '#6E8FB0'
c.colors.completion.category.bg = '#F0E6EC'
c.colors.completion.category.border.top = '#F6C9DA'
c.colors.completion.category.border.bottom = '#F6C9DA'
c.colors.completion.item.selected.fg = '#4A4A4A'
c.colors.completion.item.selected.bg = '#F6C9DA'
c.colors.completion.item.selected.border.top = '#AFCBE8'
c.colors.completion.item.selected.border.bottom = '#AFCBE8'
c.colors.completion.item.selected.match.fg = '#C97FA0'
c.colors.completion.match.fg = '#6E8FB0'
c.colors.completion.scrollbar.fg = '#AFCBE8'
c.colors.completion.scrollbar.bg = '#FDFBF9'

c.colors.statusbar.normal.fg = '#C7CCD4'
c.colors.statusbar.normal.bg = '#20232B'

c.colors.statusbar.insert.fg = '#20232B'
c.colors.statusbar.insert.bg = '#AFCBE8'

c.colors.statusbar.passthrough.fg = '#20232B'
c.colors.statusbar.passthrough.bg = '#AFCBE8'

c.colors.statusbar.command.fg = '#C7CCD4'
c.colors.statusbar.command.bg = '#20232B'

c.colors.statusbar.command.private.fg = '#C7CCD4'
c.colors.statusbar.command.private.bg = '#2E2530'

c.colors.statusbar.caret.fg = '#20232B'
c.colors.statusbar.caret.bg = '#F6C9DA'

c.colors.statusbar.caret.selection.fg = '#20232B'
c.colors.statusbar.caret.selection.bg = '#C97FA0'

c.colors.statusbar.private.fg = '#C7CCD4'
c.colors.statusbar.private.bg = '#2E2530'

c.colors.statusbar.url.fg = '#C7CCD4'
c.colors.statusbar.url.success.http.fg = '#AFCBE8'
c.colors.statusbar.url.success.https.fg = '#8FCBAE'
c.colors.statusbar.url.error.fg = '#E19BB8'
c.colors.statusbar.url.warn.fg = '#E3C173'
c.colors.statusbar.url.hover.fg = '#F6C9DA'

c.colors.statusbar.progress.bg = '#F6C9DA'

# Statusbar só aparece quando precisa (digitando comando, hint, etc.) —
# deixa a tela mais limpa quando você só está navegando, tipo Zen.
c.statusbar.show = 'in-mode'
c.statusbar.padding = {'top': 4, 'bottom': 4, 'left': 8, 'right': 8}

# --- Abas (layout vertical, inspirado no Zen Browser) ---------------------
# Zen usa uma sidebar de abas com bastante "respiro", cantos macios e
# indicador fininho. O qutebrowser não desenha cantos arredondados nem
# blur (as abas são widgets Qt, não CSS), mas dá pra chegar bem perto
# com: abas na lateral, padding generoso, favicon maior e sem números
# de índice. A sidebar agora é escura, com azul e rosa pastel só como
# destaque na aba ativa/fixada, pra contrastar bem com o fundo.

c.tabs.position = 'left'          # sidebar vertical, como no Zen
c.tabs.width = '18%'              # largura da sidebar
c.tabs.min_width = 180
c.tabs.wrap = True                # roda do fim pro começo do ciclo de abas

# Espaçamento interno de cada aba — quanto maior, mais "pill"/compacta
# ela parece (efeito visual mais próximo do Zen do que abas coladas).
c.tabs.padding = {'top': 10, 'bottom': 10, 'left': 12, 'right': 12}

# Título só com o nome da página, sem número de índice (mais limpo)
c.tabs.title.format = '{audio}{current_title}'
c.tabs.title.format_pinned = '{audio}'

# Favicons maiores e mais visíveis, já que o texto fica mais discreto
c.tabs.favicons.show = 'always'
c.tabs.favicons.scale = 1.6

# Abas fixadas (pinned) encolhem pra só o favicon, como os "espaços" do Zen
c.tabs.pinned.shrink = True

# Indicador de progresso/carregamento bem fino, quase um traço
c.tabs.indicator.width = 2
c.tabs.indicator.padding = {'top': 4, 'bottom': 4, 'left': 0, 'right': 6}

# Esconde a sidebar quando só há 1 aba (visual mais limpo, tipo Zen)
c.tabs.show = 'multiple'
c.tabs.show_switching_delay = 800

c.colors.tabs.bar.bg = '#20232B'

# Abas normais em cinza-escuro/azulado, texto claro
c.colors.tabs.odd.fg = '#C7CCD4'
c.colors.tabs.odd.bg = '#20232B'

c.colors.tabs.even.fg = '#C7CCD4'
c.colors.tabs.even.bg = '#262A34'

# Aba ativa continua em azul pastel, mas com texto escuro pra manter contraste
c.colors.tabs.selected.odd.fg = '#20232B'
c.colors.tabs.selected.odd.bg = '#AFCBE8'

c.colors.tabs.selected.even.fg = '#20232B'
c.colors.tabs.selected.even.bg = '#AFCBE8'

# Abas fixadas em tom escuro com leve toque rosado, ativa em rosa pastel
c.colors.tabs.pinned.odd.bg = '#2E2530'
c.colors.tabs.pinned.even.bg = '#332A35'
c.colors.tabs.pinned.selected.odd.fg = '#20232B'
c.colors.tabs.pinned.selected.odd.bg = '#F6C9DA'
c.colors.tabs.pinned.selected.even.fg = '#20232B'
c.colors.tabs.pinned.selected.even.bg = '#F6C9DA'

c.colors.tabs.indicator.start = '#AFCBE8'
c.colors.tabs.indicator.stop = '#F6C9DA'
c.colors.tabs.indicator.error = '#C97FA0'

# --- Hints (dicas de links) ----------------------------------------------
c.colors.hints.fg = '#4A4A4A'
c.colors.hints.bg = '#F6C9DA'
c.colors.hints.match.fg = '#6E8FB0'

# --- Mensagens (erro/aviso/info) ------------------------------------------
c.colors.messages.error.fg = '#FDFBF9'
c.colors.messages.error.bg = '#C97FA0'
c.colors.messages.error.border = '#C97FA0'

c.colors.messages.warning.fg = '#4A4A4A'
c.colors.messages.warning.bg = '#F6E2B3'
c.colors.messages.warning.border = '#D9A441'

c.colors.messages.info.fg = '#4A4A4A'
c.colors.messages.info.bg = '#DCEBF7'
c.colors.messages.info.border = '#AFCBE8'

# --- Downloads --------------------------------------------------------------
c.colors.downloads.bar.bg = '#FDFBF9'
c.colors.downloads.start.fg = '#4A4A4A'
c.colors.downloads.start.bg = '#AFCBE8'
c.colors.downloads.stop.fg = '#4A4A4A'
c.colors.downloads.stop.bg = '#F6C9DA'
c.colors.downloads.error.fg = '#FDFBF9'
c.colors.downloads.error.bg = '#C97FA0'

# --- Contexto do prompt (dialogs) -------------------------------------------
c.colors.prompts.fg = '#4A4A4A'
c.colors.prompts.bg = '#FDFBF9'
c.colors.prompts.border = '2px solid #F6C9DA'
c.colors.prompts.selected.bg = '#AFCBE8'

# --- Modo caret / seleção de texto na página --------------------------------
c.colors.webpage.bg = '#FDFBF9'
