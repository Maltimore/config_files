" OPTIONS
" set tabstop width etc.
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
" show line numbering
:set number
filetype off
filetype plugin indent on
syntax on

" Jump to the last cursor position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" Let the explore mode (file tree) be in NERDTree style
let g:netrw_liststyle=3 

" REMAPPING
" remap o so that it doesn't go to insert mode
:map o o<esc>
:map O O<esc>
" remap jk to exit insert mode
:imap jk <C-[>
" remap sl so that i can use it for the command to switch buffers
:nmap sl <C-w>
" make it easier to comment lines in python
:vmap  # :s#^#\##<cr>:noh<cr>
:vmap -# :s#^\###<cr>:noh<cr>

" only works in neovim, set 'jk' to exit terminal mode
if has('nvim')
	:tnoremap jk <C-\><C-n>
endif




" VUNDLE
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Maltimore/python-mode'
Plugin 'Maltimore/vim-latex'
Plugin 'tpope/vim-surround'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'rking/ag.vim'
Plugin 'bfredl/nvim-ipy'
Plugin 'davidhalter/jedi-vim'
" Plugin 'Shougo/deoplete.nvim'
" Plugin 'zchee/deoplete-jedi'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/IndexedSearch'
call vundle#end()



" CONQUETERM
let g:ConqueTerm_SendVisKey = '<Space>'


" PYMODE
let g:pymode_rope = 0
let g:pymode_folding = 1
let g:pymode_indent = 1
let g:pymode_run = 1
let g:pymode_run_bind = '<leader>r'
let g:pymode_lint = 0

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
let g:Tex_MultipleCompileFormats='pdf, bib,pdf'
" let g:Tex_MultipleCompileFormats='pdf, aux'

" let latex suite ignore warnings from the tex compiler
let g:Tex_IgnoredWarnings = 
	\'Font Warning'."\n"
let g:Tex_IgnoreLevel = 8


" IPython plugin
let g:nvim_ipy_perform_mappings = 0
map <silent> rr <Plug>(IPy-Run)
map <silent> ni <Plug>(IPy-Interrupt)
" run entire buffer with Ipython plugin
map <silent> ra <esc>ggVGrr<c-o>
" terminate kernel
map <silent> <c-k> <Plug>(IPy-Terminate)

" specifically for neovim:
if has('nvim')
	let g:python_host_prog = '/usr/bin/python'
	let g:python3_host_prog = '/home/maltimore/miniconda3/envs/py35/bin/python'
	let g:loaded_python_provider = 1
endif
" for ag.vim plugin
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
	nmap <silent> <RIGHT> :cnext<CR>
	nmap <silent> <LEFT> :cprev<CR>
endif


"deoplete
:let g:deoplete#enable_at_startup = 1
inoremap <silent><expr> <Tab>
\ pumvisible() ? "\<C-n>" :
\ deoplete#mappings#manual_complete()
