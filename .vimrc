" OPTIONS
" set tabstop width etc.
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
" show line numbering
:set number
filetype off
filetype plugin indent on
syntax on


" REMAPPING
" remap o so that it doesn't go to insert mode
:map o o<esc>
:map O O<esc>
" remap jk to exit insert mode
:imap jk <C-[>
" remap [ so that it behaves as <del> in other editors
:nmap [ <C-[>lxh
" remap sl so that i can use it for the command to switch buffers
:nmap sl <C-w>


" COMMANDS
:command Bash ConqueTerm bash
:command Ipython ConqueTerm ipython


" VUNDLE
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Maltimore/conque'
Plugin 'Maltimore/python-mode'
Plugin 'Maltimore/vim-latex'
" All of your Plugins must be added before the following line
call vundle#end()            " required
" end of VUNDLE


" CONQUETERM
let g:ConqueTerm_SendVisKey = '<Space>'


" PYMODE
let g:pymode_rope = 0
let g:pymode_folding = 1
let g:pymode_indent = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_rope_completion = 1

" VIM-LATEX
" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_MultipleCompileFormats='pdf, aux'

" let latex suite ignore warnings from the tex compiler
let g:Tex_IgnoredWarnings = 
	\'Font Warning'."\n"
let g:Tex_IgnoreLevel = 8
