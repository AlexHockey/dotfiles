" We don't want vi compatibility.
set nocompatible

"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
"                          PLUGIN INSTALLATION
"-----------------------------------------------------------------------------
"-----------------------------------------------------------------------------
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
Plugin 'vim-indent-object'
Plugin 'kana/vim-textobj-user'
Plugin 'glts/vim-textobj-comment'
Plugin 'AlexHockey/current-function.vim'
"Plugin 'airblade/vim-gitgutter'

" Language-specific plugins.
Plugin 'vim-ruby/vim-ruby'
Plugin 'jnwhiteh/vim-golang'
Plugin 'wting/rust.vim'
Plugin 'greyblake/vim-preview'
Plugin 'plasticboy/vim-markdown'
Plugin 'vim-scripts/DoxygenToolkit.vim'

if v:version >= 704  " YouCompleteMe requires a recent version of Vim.
  Plugin 'Valloric/YouCompleteMe'
endif

call vundle#end()

" Use langauage-specific plugins and indentation rules.
filetype plugin indent on

" Enable the backspace key in insert mode See
" http://vim.wikia.com/wiki/Backspace_and_delete_problems
set backspace=indent,eol,start

" Syntax highlighting should be on
syntax on
colorscheme ajh

" Show tabs and wrapped lines. Make sure to use actual printable characters
" when running in a terminal.
set list
if has('gui_running')
  set listchars=tab:▸\ ,
  let &showbreak='▸ '
else
  set listchars=tab:>\ ,
  let &showbreak='> '
endif

" Settings for the status bar.  This must be done after setting the color scheme
" as this seems to mess up the status bar.
hi User1 guifg=#eea040 guibg=#3a3a3a ctermfg=172 ctermbg=237
hi User2 guifg=#dd3333 guibg=#3a3a3a ctermfg=160 ctermbg=237
hi User3 guifg=#ff66ff guibg=#3a3a3a ctermfg=201 ctermbg=237
hi User4 guifg=#a0ee40 guibg=#3a3a3a ctermfg=83  ctermbg=237
hi User5 guifg=#eeee40 guibg=#3a3a3a ctermfg=226 ctermbg=237
hi User6 guifg=#afffff guibg=#3a3a3a ctermfg=159 ctermbg=237

set statusline =
set statusline +=%6*%{fugitive#statusline()}\ %* " Git branch
set statusline +=%2*%m%*                         " modified flag
set statusline +=%4*%-0.30F\ %*                  " file name
set statusline +=%3*%-0.40{GetFunctionUnderCursor()}%*  " Current function
set statusline +=%=                              " from here on, align-right
set statusline +=%1*%5l%*                        " current line
set statusline +=%2*/%L%*                        " total lines
set statusline +=%1*%4v\ %*                      " virtual column number

" Set the status line to be visible at all times.
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
  set guifont=DejaVu\ Sans\ Mono\ 10

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
    set backupdir=%HOMEPATH%/.tmp/vim
    set directory=%HOMEPATH%/.tmp/vim
  else
    set backupdir=/home/$USER/.tmp/vim
    set directory=/home/$USER/.tmp/vim
  endif

  " Don't exit vim when closing buffers.
  ":cnoreabbrev q bd
  ":cnoreabbrev x w<bar>bd

  " Turn on spellchecking
  set spell

  " By default the gvim GUI is a bit more cluttered than it needs to be. Turn
  " most of this off.
  "
  " - a: Make visually selected text pastable to outside Vim.
  " - m: Show the menu bar (File, Edit, etc) for consistency with other windows.
  set guioptions=am
endif

" Navigation thought quickfix lists. Note that when the GUI is running we map
" this to Ctrl-Shift-<cursor keys> which is nice and intuitive. However most
" terminals have no mapping for these key combinations, so we have to use
" alternative mappings (Ctrl-Shift-<h,j,k,l>).
if has('gui_running')
  nnoremap <C-S-Down> :cn<CR>
  nnoremap <C-S-Up> :cp<CR>
  nnoremap <C-S-Right> :copen<CR>
  nnoremap <C-S-Left> :cclose<CR>
else
  nnoremap <C-S-j> :cn<CR>
  nnoremap <C-S-k> :cp<CR>
  nnoremap <C-S-l> :copen<CR>
  nnoremap <C-S-h> :cclose<CR>
endif

" Search settings.
" - Highlight search matches.
" - Turn on incremental search.
" - Ignore case except when the search term contains uppercase (that is what
"   ignorecase and smartcase do).
set hlsearch
set incsearch
set ignorecase
set smartcase

" Make Ctrl-C escape *and* clear the current highlighting.
nmap <C-C> <esc>:noh<cr>

" Search for tag files in the current directory, and all parent directories.
set tags=tags;/

" Ignore binary files in tab completion, Ctrl-P, etc.
set wildignore+=*.o,*.so,*.git/*,*.svn/*

" Correct filetypes for debian special files and markdown.
au BufNewFile,BufRead *.d set filetype=sh
au BufNewFile,BufRead *.md set filetype=markdown

" Make grep ignore common false positives - binary files (-I) and tags.
set grepprg=grep\ -nI\ --exclude\ 'tags'\ $*\ /dev/null\ --exclude-dir=.svn\ --exclude\ \*.js

" C formatting options
set cino=(0,g0,:0,N-s

" Format shell scripts as bash.
let is_bash=1

" Use hyphen as a bullet in comments.  I've forgotten what this clusterfuck of
" an expression does.
set flp=^\\s*\\(\\d\\+[\\]:.)}\\t]\\\\|-\\)\\s\\s\\+

" Recognize numbered lists in comments.
set formatoptions+=n

" When opening new split windows make the right (or lower) window the active
" one. No particular reason for this - it just matches my expectations.
set splitbelow
set splitright

" Turn on line numbers in the gutter.
set number

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
"                             KEY MAPS
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------

" Use ',' as a leader key as it's easier to type than '\'
let mapleader = ","

" Map ; to : in command mode (as it's easier to type)
nnoremap ; :

" Common typos
nnoremap :Q :q
nnoremap :X :x
nnoremap :W :w

" Grep for word under the cursor.
nnoremap <Leader>gw :grep -r <cword> .<CR>

" Make F2 save the current file.
nnoremap <F2> :w<CR>
inoremap <F2> <Esc>:w<CR>

" Navigate through several possible tag matches.
nnoremap <F7> :tprev<cr>
nnoremap <F8> :tnext<cr>

" Key mapping to replace the word under the cursor.
nmap <leader>rw "ryiw:%s/<C-r>r/<C-r>r/gc<left><left><left>

" Key mapping to replace the current visually selected text.
vmap <leader>rv "ry<Esc>:%s/<C-r>r//gc<left><left><left>

" When searching through a file, center the match in the window. If you don;t
" do this Vim can put the match at the very bottom/top of the window, which
" means you can't seen the code surrounding the match very well.
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
" Also map the star number pad key.
nnoremap <kMultiply> *zz
nnoremap # #zz

" Shortcut to open your vimrc.
nmap <leader>v :e ~/.vimrc<cr>

" Make tab completion work more like how it does on Linux.
set completeopt=longest,menuone
set wildmode=longest,list,full

" Strip trailing whitespace from the current file.
nmap <leader>sw :%s/\s*$//<CR>:noh<CR>:w<CR>

" Blow away all vim backups.
cmap <leader>zap !( cd ~/.tmp/vim && rm $( ls -A ) )

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
nnoremap <leader>9 :call FoldArgumentsOntoMultipleLines()<CR>

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

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
"                             REFACTORINGS
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------

" These look a bit mad, but they are effectively just macros that have been put
" in .vimrc for future use.

" Wrap a visual-line block in an if() statement.
vnoremap <leader>if "zdOif ()<cr>{<cr>}<esc>k"zp>`]<esc>kkla

" 'Unwrap' a text block. E.g.
"
" Cursor is here.
"   |
"   |
"   V
"   if (foo)
"   {
"     bar
"   }
"
" Typing `<leader>uw` produces:
"
"  bar
nnoremap <leader>uw ^mz/{<cr>"zdi{V'zd"zP<`]:noh<cr>

" Right justify the '\' in preprocessor definitions.
vnoremap <leader>rj :s/\s*\\$/\=repeat(' ', 80-col('.')).'\'<cr>:noh<cr>

" #if 0 out a visually selected block of text.
vnoremap <leader>#if "zdO#if 0<cr>#endif<esc>"zP

"------------------------------------------------------------------------------
"------------------------------------------------------------------------------
"                             PLUGIN CONFIGURATION
"------------------------------------------------------------------------------
"------------------------------------------------------------------------------

"------------------------------------------------------------------------------
" Vundle settings
"------------------------------------------------------------------------------

" Clone git modules over SSH.
let g:vundle_default_git_proto = 'git'

"------------------------------------------------------------------------------
" CtrlP settings
"------------------------------------------------------------------------------

" Use the project root for Ctrl-P searches (this is the folder that contains
" .git).
let g:ctrlp_working_path_mode = ''
let g:ctrlp_max_files=0

" Useful bindings (find file, find buffer, find recent).
nmap <Leader>ff :<C-U>CtrlP<CR>
nmap <Leader>fb :<C-U>CtrlPBuffer<CR>
nmap <Leader>fr :<C-U>CtrlPMRU<CR>

"------------------------------------------------------------------------------
" Ultisnips settings
"------------------------------------------------------------------------------

" Change the completion trigger to not interfere with YCM
let g:UltiSnipsExpandTrigger="<c-j>"

" Use the snippets in ~/.vim/snippets in addition to built in snippets.
let g:UltiSnipsSnippetDirectories=["UltiSnips", "mysnippets"]

" Shortcut to go straight to the ultisnips folder (makes it easier to add new
" snippets).
nnoremap <leader>us :e ~/.vim/bundle/ultisnips/UltiSnips/<CR>

"------------------------------------------------------------------------------
" YouCompleteMe settings.
"------------------------------------------------------------------------------

" Don't clutter the UI with compilation warnings/errors.
let g:ycm_enable_diagnostic_signs=0
let g:ycm_enable_diagnostic_highlighting=0
let g:ycm_echo_current_diagnostic=0

" Don't complete in comments
let g:ycm_complete_in_comments=0

" Turn off semantic completion - this is personal preference.
let g:ycm_filetype_specific_completion_to_disable = { 'c': 1, 'cpp': 1, 'python': 1 }

let g:ycm_rust_src_path = '/home/alex/.multirust/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src'

"------------------------------------------------------------------------------
" Doxygen toolkit settings
"------------------------------------------------------------------------------

" Don't include '@brief' tags
let g:DoxygenToolkit_briefTag_pre=""

" Use C++ style triple-/ comments.
let g:DoxygenToolkit_commentType = "C++"

"------------------------------------------------------------------------------
" Vim markdown settings
"------------------------------------------------------------------------------

" Disable folding - it's super annoying.
let g:vim_markdown_folding_disabled = 1
