" set tabstop width etc.
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
" show line numbering
:set number

" remap o so that it doesn't go to insert mode
:map o o<esc>
" remap jk to exit insert mode
:imap jk <C-[>
" remap [ so that it behaves as <del> in other editors
:nmap [ <C-[>lxh
" remap sl so that i can use it for the command to switch buffers
:nmap sl <C-w>



" ConqueTerm stuff
let g:ConqueTerm_SendVisKey = '<Space>'


"The following is for the pymode plugin
"Pathogen load
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on


let g:pymode_rope = 0

" ALL THE REST IS JUST ABOUT VIM-LATEX
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
