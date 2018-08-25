" vim: set foldmethod=marker:

" C formatting options
set cino=(0,g0,:0,N-s

" Refactorings {{{
"
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
"}}}
