" vim: set foldmethod=marker:
"
" This file is folded by default. Use:
" -  zR to expand all folds.
" -  zM to close all folds.
" -  zc to close a single fold
" -  zo to open a single fold
" -  za to toggle a fold (open a closed one or close an open one. This is
"    genrally more useful than zc or zo).

" We don't want vi compatibility. This command must be first.
set nocompatible

" Use ',' as a leader key as it's easier to type than '\'
let mapleader = ","

" Shortcut to open your vimrc.
nmap <leader>v :e ~/.vimrc<cr>

" Plugins {{{
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'VundleVim/Vundle.vim'

Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-abolish'
Plugin 'vim-indent-object'
Plugin 'kana/vim-textobj-user'
Plugin 'glts/vim-textobj-comment'
Plugin 'AlexHockey/current-function.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'mattn/webapi-vim'

" Language-specific plugins.
Plugin 'vim-ruby/vim-ruby'
Plugin 'jnwhiteh/vim-golang'
Plugin 'rust-lang/rust.vim'
Plugin 'greyblake/vim-preview'
Plugin 'plasticboy/vim-markdown'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'vim-scripts/DoxygenToolkit.vim'
Plugin 'vim-scripts/supp.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'cespare/vim-toml'
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'chr4/nginx.vim'
Plugin 'tyru/open-browser.vim'
Plugin 'aklt/plantuml-syntax'
Plugin 'weirongxu/plantuml-previewer.vim'

" Colorschemes
Plugin 'joshdick/onedark.vim'
Plugin 'drewtempelmeyer/palenight.vim'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'dracula/vim'
Plugin 'haishanh/night-owl.vim'

if v:version >= 704  " YouCompleteMe requires a recent version of Vim.
  Plugin 'Valloric/YouCompleteMe'
endif

" And finally, the clearwater plugin
Plugin 'git@gitlab.datcon.co.uk:ajh/clearwater.vim.git'

call vundle#end()

" Use langauage-specific plugins and indentation rules.
filetype plugin indent on
"}}}

" Syntax Highlighting {{{
syntax on

" Enable th full set of terminal colors.
set termguicolors

"Use the onedark color scheme with some modifications:
" -  Enable the use of italics.
" -  The default red color is really bright and distracting, so override it with
"    a more pastel shade.
let g:onedark_color_overrides = {
\ "dark_red": {"gui": "#ff87af", "cterm": "211", "cterm16": "9" },
\ "red": {"gui": "#ff87af", "cterm": "211", "cterm16": "9" }
\}
let g:onedark_terminal_italics = 1
colorscheme onedark

" Format shell scripts as bash.
let is_bash=1
" }}}

" Status Line {{{
" Set the status line to be visible at all times.
set laststatus=2

" Use a nice color scheme for the status line. Dracula is more visualy intense
" than onedark (the scheme used for the rest of the editor) so this makes the
" statsu line stand out a bit more.
let g:airline_theme = 'dracula'

" Make airline use the powerline fonts, so we get a pretty looking line with
" chevrons, git branch symbols, etc.
let g:airline_powerline_fonts = 1

" By default the central section of the statusline contains the current file. As
" that is displayed at the top of the window, we can use it for something
" different. I find that displaying the current function is the most useful.
let g:airline_section_c = '%{GetFunctionUnderCursor()}'
" }}}

" Find / Replace {{{

" Highlight search matches.
set hlsearch

" Turn on incremental search.
set incsearch

" Ignore case except when the search term contains uppercase (that is what
" ignorecase and smartcase do).
set ignorecase
set smartcase

" When searching through a file, center the match in the window. If you don't
" do this Vim can put the match at the very bottom/top of the window, which
" means you can't seen the code surrounding the match very well.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap <kMultiply> *zz
nnoremap # #zz

" Key mapping to replace the word under the cursor.
nmap <leader>rw "ryiw:%s/<C-r>r/<C-r>r/gc<left><left><left>

" Key mapping to replace the current visually selected text.
vmap <leader>rv "ry<Esc>:%s/<C-r>r//gc<left><left><left>

" Make Ctrl-C escape *and* clear the current highlighting.
nmap <C-C> <esc>:noh<cr>

" }}}

" Grep Settings {{{

" Make grep ignore common false positives - binary files (-I) and tags.
set grepprg=grep\ -nI\ --exclude\ 'tags'\ $*\ /dev/null\ --exclude-dir=.svn\ --exclude\ \*.js\ --exclude\ \*.memcheck

" Grep for word under the cursor.
nnoremap <Leader>gw :grep -rw <cword> .<CR>

" Navigation thought quickfix lists.
nnoremap <C-S-Down> :cn<CR>
nnoremap <C-S-Up> :cp<CR>
nnoremap <C-S-Right> :copen<CR>
nnoremap <C-S-Left> :cclose<CR>

" }}}

" Tagging {{{

" Search for tag files in the current directory, and all parent directories.
set tags=tags;/

" Navigate through several possible tag matches.
nnoremap <F7> :tprev<cr>
nnoremap <F8> :tnext<cr>

" Rebuild tags. This function searches up from the current directory until it
" finds a directory with a tags file. It then rebuilds this tags file by
" calling `ctags .`
function! RebuildTags(cwd)
python << EOF
import vim, os
cwd = vim.eval("a:cwd")
elems = cwd.split(os.sep)
elems = list(reversed(elems))

for levels_up in range(len(elems)):
  target = os.sep.join(reversed(["tags"] + elems[levels_up : ]))
  if os.path.isfile(target):
    print "Rebuilding tagfile '%s' ..." % target
    os.system("( cd $( dirname %s ) && ctags . )" % target)
    print "Done"
EOF
endfunction
command! Tagme call RebuildTags(getcwd())
" }}}

" Miscellaneous Behavior Tweaks {{{
"
" This section contains various small tweaks to vim's behavior to make it be a
" little more funcitonal or intuitive.

" Allow switching between buffers even if the current buffer has unsaved
" changes
set hidden

" Enable the backspace key in insert mode See
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" Enable mouse support in the terminal.
set mouse=a

" When opening new split windows make the right (or lower) window the active
" one. No particular reason for this - it just matches my expectations.
set splitbelow
set splitright

" Make the unnamed register the same as the clipboard register.  The unnamed
" register is where text is stored when you yank it.  By making it the same
" as the clipboard, yanking and pasting in Vim affects the system clipboard.
" http://vim.wikia.com/wiki/VimTip21
set clipboard=unnamedplus

" Disable 'bracketed paste mode' which messes with xfce4 terminals
set t_BE=

" Make tab completion work more like how it does on Linux.
set completeopt=longest,menuone
set wildmode=longest,list,full

" Put all the swap files in one place.
set directory^=$HOME/.vim/tmp//

" Blow away all vim backups. Consists of:
" - A function to actually remove the backups.
" - A command to make the function easier to call.
function! RemoveSwapFiles()
  execute "! rm $HOME/.vim/tmp/*"
endfunction

command! ClearSwap call RemoveSwapFiles()

" Turn on line numbers in the gutter.
set number

" Ignore binary files in tab completion, Ctrl-P, etc.
set wildignore+=*.o,*.so,*.git/*,*.svn/*

" Only wrap text at word boundaries - wrapping in the middle of a word is rarely
" useful.
set linebreak
" }}}

" Whitespace Settings {{{

" Show tabs and wrapped lines.
set list
set listchars=tab:▸\ ,
let &showbreak='▸ '

" Strip trailing whitespace on save - for all file types.
" See http://vim.wikia.com/wiki/Remove_unwanted_spaces
autocmd BufWritePre * :%s/\s\+$//e

" }}}

" Code Formatting {{{

" Automatic wrapping of comments at 80 characters, and put a gutter at a width
" of 80 characters.
set formatoptions+=c
set textwidth=80
set colorcolumn=81

" C formatting options
set cino=(0,g0,:0,N-s

" Use hyphen as a bullet in comments.  I've forgotten what this clusterfuck of
" an expression does.
set flp=^\\s*\\(\\d\\+[\\]:.)}\\t]\\\\|-\\)\\s\\s\\+

" Recognize numbered lists in comments.
set formatoptions+=n

" }}}

" Typos and Ergonomics {{{

" Map ; to : in command mode (as it's easier to type)
nnoremap ; :

" Common typos
nnoremap :Q :q
nnoremap :X :x
nnoremap :W :w

" Make F2 save the current file.
nnoremap <F2> :w<CR>
inoremap <F2> <Esc>:w<CR>

" }}}

" Refactorings {{{
"
" Helper function to split function arguments onto multiple lines.
" Turns
"   foo(1, 2, 3)
"
" into
"   foo(1,
"       2,
"       3)
function! FoldArgumentsOntoMultipleLines()
    substitute@,\s*@,\r@ge
    normal v``="
endfunction

" A key map to call the above function.
nnoremap <leader>9 :call FoldArgumentsOntoMultipleLines()<CR>
"}}}

" Vundle Settings {{{
" Clone git modules over SSH.
let g:vundle_default_git_proto = 'git'
"}}}

" CtrlP settings {{{

" Use the project root for Ctrl-P searches (this is the folder that contains
" .git).
let g:ctrlp_working_path_mode = ''

" Don't limit the number of files that Ctrl-P returns.
let g:ctrlp_max_files=0

" Useful bindings (find file, find buffer, find recent).
nmap <Leader>ff :<C-U>CtrlP<CR>
nmap <Leader>fb :<C-U>CtrlPBuffer<CR>
nmap <Leader>fr :<C-U>CtrlPMRU<CR>
"}}}

" Ultisnips settings {{{

" Change the completion trigger to not interfere with YCM
let g:UltiSnipsExpandTrigger="<c-j>"

" Shortcut to go straight to the ultisnips folder (makes it easier to add new
" snippets).
nnoremap <leader>us :e ~/.vim/mysnippets<cr>
" }}}

" YouCompleteMe settings {{{

" Don't clutter the UI with compilation warnings/errors.
let g:ycm_enable_diagnostic_signs=0
let g:ycm_enable_diagnostic_highlighting=0
let g:ycm_echo_current_diagnostic=0

" Don't complete in comments
let g:ycm_complete_in_comments=0

" The YcmCompleter has a bunch of useful functions. Map some of the more commen
" ones to keybindings.

" Type-aware goto declaration. This is useful when wanting to find the
" declaration of a function with a short, common name, that may be used in many
" different classes or projects.
nmap <leader>yg :YcmCompleter GoTo<cr>

" Print the type of the variable under the cursor.
nmap <leader>yt :YcmCompleter GetType<cr>
" }}}

" Doxygen toolkit settings {{{

" Don't include '@brief' tags
let g:DoxygenToolkit_briefTag_pre=""

" Use C++ style triple-/ comments.
let g:DoxygenToolkit_commentType = "C++"
"}}}

" Vim markdown settings {{{

" Disable folding the document by default - it's super annoying.
let g:vim_markdown_folding_disabled = 1
" }}

" Rust Vim settings {{{
let g:rust_clip_command = 'xclip -selection clipboard'
" }}}

" Vim markdown preview settings {{{
let vim_markdown_preview_github = 1
let vim_markdown_preview_toggle = 1
" }}}
