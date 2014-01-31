set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "ajh"

hi Normal          guifg=#f6f3e8 guibg=#121212 ctermfg=255 ctermbg=233

"" Colours with a charcoal background (used for the normal text).
hi Orange          guifg=#eea040 guibg=#121212 ctermfg=172 ctermbg=233
hi Red             guifg=#dd3333 guibg=#121212 ctermfg=160 ctermbg=233
hi Pink            guifg=#ff66ff guibg=#121212 ctermfg=201 ctermbg=233
hi PinkBold        guifg=#ff66ff guibg=#121212 ctermfg=201 ctermbg=233  gui=BOLD
hi LightGreen      guifg=#a0ee40 guibg=#121212 ctermfg=83  ctermbg=233
hi Green           guifg=#a8ff60 guibg=#121212 ctermfg=10  ctermbg=233
hi Cyan            guifg=#afffff guibg=#121212 ctermfg=159 ctermbg=233
hi Grey            guifg=#626262 guibg=#121212 ctermfg=241 ctermbg=233
hi GreyItalic      guifg=#626262 guibg=#121212 ctermfg=241 ctermbg=233 gui=ITALIC
hi Yellow          guifg=#ffff80 guibg=#121212 ctermfg=191 ctermbg=233
hi Salmon          guifg=#FF8787 guibg=#121212 ctermfg=210 ctermbg=233
hi Ochre           guifg=#FFD2A7 guibg=#121212 ctermfg=186 ctermbg=233
hi Blue            guifg=#9090FF guibg=#121212 ctermfg=12  ctermbg=233
hi Purple          guifg=#9932CC guibg=#121212 ctermfg=92  ctermbg=233
hi Teal            guifg=#00A0A0 guibg=#121212 ctermfg=37  ctermbg=233
hi Invisible       guifg=#121212 guibg=#121212 ctermfg=233 ctermbg=233
hi CherryBG        guifg=#f6f3e8 guibg=#ff005f ctermfg=241 ctermbg=197

" Colours with a light grey background (used for the status line)
hi BackgroundSL    guifg=NONE    guibg=#3a3a3a ctermfg=NONE ctermbg=237
hi OrangeSL        guifg=#eea040 guibg=#3a3a3a ctermfg=172  ctermbg=237
hi RedSL           guifg=#dd3333 guibg=#3a3a3a ctermfg=160  ctermbg=237
hi PinkSL          guifg=#ff66ff guibg=#3a3a3a ctermfg=201  ctermbg=237
hi PinkBoldSL      guifg=#ff66ff guibg=#3a3a3a ctermfg=201  ctermbg=237 gui=BOLD
hi LightGreenSL    guifg=#a0ee40 guibg=#3a3a3a ctermfg=83   ctermbg=237
hi CyanSL          guifg=#afffff guibg=#3a3a3a ctermfg=159  ctermbg=237

hi StatusLine       guibg=#3a3a3a gui=italic    ctermfg=237 ctermbg=237  cterm=italic
hi StatusLineNC     guibg=#3a3a3a gui=NONE      ctermbg=237  cterm=NONE
hi VertSplit        guifg=#3a3a3a guibg=#3a3a3a ctermfg=16  ctermbg=16
hi Cursor           guifg=#000000 guibg=#ffffff ctermfg=0   ctermbg=15
hi Visual           guifg=NONE        guibg=#262D51     gui=NONE      ctermfg=NONE   ctermbg=17     cterm=NONE
hi ModeMsg          guifg=black       guibg=#C6C5FE     gui=BOLD      ctermfg=black  ctermbg=189     cterm=BOLD

if version >= 700 " Vim 7.x specific colors
  hi CursorLine     guifg=NONE    guibg=#262D51   gui=NONE      ctermfg=NONE   ctermbg=17    cterm=NONE
  hi CursorColumn   guifg=NONE    guibg=#121212   gui=NONE      ctermfg=NONE   ctermbg=16    cterm=NONE
  hi MatchParen     guifg=#f6f3e8 guibg=#857b6f   gui=BOLD      ctermfg=233    ctermbg=101   cterm=BOLD
  hi Pmenu          guifg=#f6f3e8 guibg=#444444   gui=NONE      ctermfg=233    ctermbg=59    cterm=NONE
  hi PmenuSel       guifg=#000000 guibg=#cae682   gui=NONE      ctermfg=black  ctermbg=186   cterm=NONE
  hi Search         guifg=NONE    guibg=#2f2f00   gui=underline ctermfg=NONE   ctermbg=16    cterm=underline
endif

hi Error            guifg=NONE        guibg=NONE        gui=undercurl ctermfg=NONE   ctermbg=NONE        cterm=undercurl      guisp=#FF6C60 " undercurl color
hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white  ctermbg=203     cterm=BOLD
hi WarningMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white  ctermbg=203     cterm=BOLD

hi! link NonText Invisible

hi! link LineNr Teal
hi! link SpecialKey Grey

" Syntax highlighting
hi! link Comment GreyItalic
hi! link String  Green
hi! link Number Pink
hi! link Keyword Yellow
hi! link PreProc Yellow
hi! link Conditional Yellow
hi! link Statement Yellow
hi! link Special Yellow
hi! link Todo       CherryBG
hi! link Constant   Salmon
hi! link Identifier Ochre
hi! link Function   Blue
hi! link Type       Purple
hi! link Delimiter  Teal

hi! link shVariable Cyan
hi! link cppSTLtype Normal

hi! link Operator Normal
hi link Character       Constant
hi link Boolean         Constant
hi link Float           Number
hi link Repeat          Statement
hi link Label           Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link SpecialChar     Special
hi link SpecialComment  Special
hi link Debug           Special
hi! link ColorColumn    BackgroundSL

hi link CtrlPMode1 PinkBoldSL
hi link CtrlPMode2 LightGreenSL
hi! link qfLineNr Ochre
