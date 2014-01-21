" Autoload vimrc when it changes.
autocmd! bufwritepost .vimrc source %

" Load all plugins
call pathogen#infect()

" Use ',' as a leader key as it's easier to type than '\'
let mapleader = ","

" We don't want vi compatibility.
set nocompatible

" Enable the backspace key in insert mode
" See http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" Syntax highlighting should be on
syntax on
colorscheme ajh

" Use langauage-specific plugins and indentation rules.
filetype plugin indent on

" Settings for the status bar.  This must be done after setting the colorscheme
" as this seems to mess up the status bar.
hi User1 guifg=#eea040 guibg=#222222 ctermfg=172 ctermbg=235
hi User2 guifg=#dd3333 guibg=#222222 ctermfg=160 ctermbg=235
hi User3 guifg=#ff66ff guibg=#222222 ctermfg=201 ctermbg=235
hi User4 guifg=#a0ee40 guibg=#222222 ctermfg=83  ctermbg=235
hi User5 guifg=#eeee40 guibg=#222222 ctermfg=226 ctermbg=235

set statusline=
set statusline +=%1*\ %n\ %*            "buffer number
set statusline +=%5*%{&ff}%*            "file format
set statusline +=%3*%y%*                "file type
set statusline +=%4*\ %<%F%*            "full path
set statusline +=%2*%m%*                "modified flag
set statusline +=%1*%=%5l%*             "current line
set statusline +=%2*/%L%*               "total lines
set statusline +=%1*%4v\ %*             "virtual column number
set statusline +=%2*0x%04B\ %*          "character under cursor

set laststatus=2

" By default tabs are 2 characters, replace tabs with spaces.  These can be
" overwridden by language-specific files in the ftplugin directory.
set shiftwidth=2
set tabstop=2
set expandtab

" Strip trailing whitespace on save - for all file types.
" See http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

" Automatic wrapping of comments at 80 characters, and put a gutter at a width
" of 80 characters.
set formatoptions+=c
set textwidth=80
set colorcolumn=81

" Allow switching between buffers even if the current buffer has unsaved
" changes
set hidden

if has('gui_running')
  " Settings for GUI mode

  " Change the font and font size.
  set guifont=Consolas\ 10

  " Maximise the window (on Windows)
  " http://vim.wikia.com/wiki/Maximize_or_set_initial_window_size
  "au GUIEnter * simalt ~x

  " Make the unnamed register the same as the clipboard register.  The unnamed
  " register is where text is stored when you yank it.  By making it the same
  " as the clipboard, yanking and pasting in Vim affects the system clipboard.
  " http://vim.wikia.com/wiki/VimTip21
  if has("win32") || has("win16")
    set clipboard=unnamed
  else
    set clipboard=unnamedplus
  endif

  " Put temporary files in the temp directory, rather than the current
  " directory (so they don't turn up in svn/git status).
  " http://stackoverflow.com/questions/4824188/git-ignore-vim-temporary-files
  if has("win32") || has("win16")
    " TODO the same thing fow windows.
  else
    set backupdir=/home/$USER/.tmp/vim
    set directory=/home/$USER/.tmp/vim
  endif

  " Don't exit vim when closing buffers.
  :cnoreabbrev q bd
  :cnoreabbrev x w<bar>bd
endif

" Navigation thought quickfix lists.
nnoremap <C-S-Down> :cn<CR>
nnoremap <C-S-Up> :cp<CR>
nnoremap <C-S-Right> :copen<CR>
nnoremap <C-S-Left> :cclose<CR>

" Allow case insensitive incremental searches.
set hlsearch
set incsearch
set ignorecase
set smartcase

" Don't wrap lines if they don't fit into the window.
set nowrap

" Search for tag files in the current directory, and all parent directories.
set tags=tags;/

" Correct filetypes for debian special files and markdown.
au BufNewFile,BufRead *.d set filetype=sh
au BufNewFile,BufRead *.md set filetype=markdown

" Make grep ignore common false positives - binary files (-I) and tags.
set grepprg=grep\ -nI\ --exclude\ 'tags'\ $*\ /dev/null

" C formatting options
set cino=(0
set cinoptions+=g0

" Bash formatting options.
let is_bash=1

" Doxygen config.
let g:DoxygenToolkit_commentType = "C++"
let g:DoxygenToolkit_briefTag_pre = ""

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
"                             KEY MAPS
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------

" Map ; to : in command mode (as it's easier to type)
nmap ; :

" Common typos
nmap :Q :q
nmap :X :x
nmap :W :w

" Replace thw word under the cursor with the text in the clipboard
:nmap <Leader>r ciw<C-r>0<ESC>

" Make HOME put the cursor at the start of the text on this line, rather than
" the start of the line.
inoremap <HOME> <ESC>I

" Grep for word under the cursor.
:nmap <Leader>gw :grep -r <cword> .<CR>

function! FoldArgumentsOntoMultipleLines()
    substitute@,\s*@,\r@ge
    normal v``="
endfunction
nmap <leader>9 :call FoldArgumentsOntoMultipleLines()<CR>

nmap <F2> :w<CR>
imap <F2> <Esc>:w<CR>
imap <C-Enter> <ESC>o
imap <S-Enter> <ESC>O
imap <C-S-Enter> <ENTER><ESC>O

cnoremap <leader>us e ~/.vim/bundle/ultisnips/UltiSnips/

nmap <leader>rr :%s/
nmap <leader>rw "ryiw:%s/<C-r>r//gc<left><left><left>

"Taken from http://vim.wikia.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
set completeopt=longest,menuone

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
"                             PLUGIN CONFIGURATION
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------

"---------------------------------------------------------------------------
" CtrlP settings

" Use the project root for Ctrl-P searches (this is the folder that contains
" .git).
let g:ctrlp_working_path_mode = ''

" Useful bindings (find file, find buffer, find recent).
:nmap <Leader>ff :<C-U>CtrlP<CR>
:nmap <Leader>fb :<C-U>CtrlPBuffer<CR>
:nmap <Leader>fr :<C-U>CtrlPMRU<CR>


"------------------------------------------------------------------------------
" clang_complete configuration.

"Select the first completion option but don't insert it into the code.
let g:clang_auto_select=1
let g:clang_hl_errors=0
let g:clang_complete_macros=1
let g:clang_close_preview=1
let g:clang_snippets=1
let g:clang_snippets_engine='ultisnips'


"------------------------------------------------------------------------------
" YouCompleteMe settings.

" Don't clutter the UI with compilation warnings/errors.
let g:ycm_enable_diagnostic_signs=0
let g:ycm_enable_diagnostic_highlighting=0
let g:ycm_echo_current_diagnostic=0

" Make ultisnips work again.
function! g:UltiSnips_Complete()
    call UltiSnips_ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips_JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"