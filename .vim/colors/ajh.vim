set background=dark
hi clear

if exists("syntax_on")
  syntax reset
endif

let colors_name = "ajh"

"hi Example         guifg=NONE        guibg=NONE        gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE

" General colors
hi Normal           guifg=#f6f3e8     guibg=black       gui=NONE      ctermfg=230    ctermbg=black       cterm=NONE
hi NonText          guifg=#070707     guibg=black       gui=NONE      ctermfg=16     ctermbg=black       cterm=NONE

hi Cursor           guifg=black       guibg=white       gui=NONE      ctermfg=black  ctermbg=white       cterm=NONE
hi LineNr           guifg=#7c7c7c     guibg=black       gui=NONE      ctermfg=102    ctermbg=black       cterm=NONE

hi VertSplit        guifg=#202020     guibg=#202020     gui=NONE      ctermfg=16     ctermbg=16     cterm=NONE
hi StatusLine       guifg=#CCCCCC     guibg=#202020     gui=italic    ctermfg=188    ctermbg=16     cterm=italic
hi StatusLineNC     guifg=black       guibg=#202020     gui=NONE      ctermfg=black  ctermbg=16     cterm=NONE

hi Folded           guifg=#a0a8b0     guibg=#384048     gui=NONE      ctermfg=145    ctermbg=59     cterm=NONE
hi Title            guifg=#f6f3e8     guibg=NONE        gui=bold      ctermfg=230    ctermbg=NONE        cterm=bold
hi Visual           guifg=NONE        guibg=#262D51     gui=NONE      ctermfg=NONE   ctermbg=17     cterm=NONE

hi SpecialKey       guifg=#808080     guibg=#343434     gui=NONE      ctermfg=102    ctermbg=59     cterm=NONE

hi WildMenu         guifg=green       guibg=yellow      gui=NONE      ctermfg=green  ctermbg=yellow      cterm=NONE
hi PmenuSbar        guifg=black       guibg=white       gui=NONE      ctermfg=black  ctermbg=white       cterm=NONE
"hi Ignore           guifg=gray        guibg=black       gui=NONE     ctermfg=gray   ctermbg=black      cterm=NONE

hi Error            guifg=NONE        guibg=NONE        gui=undercurl ctermfg=NONE   ctermbg=NONE        cterm=undercurl      guisp=#FF6C60 " undercurl color
hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white  ctermbg=203     cterm=BOLD
hi WarningMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=white  ctermbg=203     cterm=BOLD
hi LongLineWarning  guifg=NONE        guibg=#371F1C     gui=underline ctermfg=NONE   ctermbg=52     cterm=underline

" Message displayed in lower left, such as --INSERT--
hi ModeMsg          guifg=black       guibg=#C6C5FE     gui=BOLD      ctermfg=black  ctermbg=189     cterm=BOLD

if version >= 700 " Vim 7.x specific colors
  hi CursorLine     guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE   ctermbg=16     cterm=NONE
  hi CursorColumn   guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE   ctermbg=16     cterm=NONE
  hi MatchParen     guifg=#f6f3e8     guibg=#857b6f     gui=BOLD      ctermfg=230    ctermbg=101     cterm=BOLD
  hi Pmenu          guifg=#f6f3e8     guibg=#444444     gui=NONE      ctermfg=230    ctermbg=59     cterm=NONE
  hi PmenuSel       guifg=#000000     guibg=#cae682     gui=NONE      ctermfg=black  ctermbg=186     cterm=NONE
  hi Search         guifg=NONE        guibg=#2f2f00     gui=underline ctermfg=NONE   ctermbg=16     cterm=underline
endif

" Syntax highlighting
"hi Comment          guifg=#7fefef     guibg=NONE        gui=italic    ctermfg=123    ctermbg=NONE        cterm=NONE
hi Comment          guifg=#626262     guibg=NONE        gui=italic    ctermfg=241    ctermbg=NONE        cterm=NONE
hi String           guifg=#A8FF60     guibg=NONE        gui=NONE      ctermfg=10     ctermbg=NONE        cterm=NONE
hi Number           guifg=#FF73FD     guibg=NONE        gui=NONE      ctermfg=213    ctermbg=NONE        cterm=NONE

hi Keyword          guifg=#ffff80     guibg=NONE        gui=NONE      ctermfg=191    ctermbg=NONE        cterm=NONE
hi PreProc          guifg=#ffff80     guibg=NONE        gui=NONE      ctermfg=191    ctermbg=NONE        cterm=NONE
hi Conditional      guifg=#ffff80     guibg=NONE        gui=NONE      ctermfg=191    ctermbg=NONE        cterm=NONE           " if else end

hi Todo             guifg=#f6f3e8     guibg=#ff005f     gui=NONE      ctermfg=241    ctermbg=197        cterm=NONE
hi Constant         guifg=#FF8787     guibg=NONE        gui=NONE      ctermfg=210    ctermbg=NONE        cterm=NONE

hi Identifier       guifg=#FFD2A7     guibg=NONE        gui=NONE      ctermfg=186    ctermbg=NONE        cterm=NONE           " Class members
hi Function         guifg=#9090FF     guibg=NONE        gui=NONE      ctermfg=12     ctermbg=NONE        cterm=NONE
hi Type             guifg=#9932CC     guibg=NONE        gui=NONE      ctermfg=92     ctermbg=NONE        cterm=NONE
hi Statement        guifg=#ffff80     guibg=NONE        gui=NONE      ctermfg=11     ctermbg=NONE        cterm=NONE

hi Special          guifg=#ffff80     guibg=NONE        gui=NONE      ctermfg=228    ctermbg=NONE        cterm=NONE
hi Delimiter        guifg=#00A0A0     guibg=NONE        gui=NONE      ctermfg=37     ctermbg=NONE        cterm=NONE
hi Operator         guifg=white       guibg=NONE        gui=NONE      ctermfg=white  ctermbg=NONE        cterm=NONE

hi shVariable       guifg=#afffff
hi pythonStrFormatting guifg=#FFD2A7
hi VisibleWhitespace             guifg=NONE guibg=#afffff gui=NONE

syntax keyword WordError destory
hi WordError        guifg=white       guibg=#ff005f     gui=NONE      ctermfg=230    ctermbg=197         cterm=NONE

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
hi ColorColumn      guifg=NONE        guibg=#3c3c3c     gui=NONE      ctermfg=NONE    ctermbg=59     cterm=NONE
