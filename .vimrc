" OPTIONS
" set tabstop width etc.
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
" show line numbering
:set number
filetype off
filetype plugin indent on
syntax on
" when opening a new file and typing the filename, this will give
" more bashlike behavior on hitting <tab>
set wildmode=longest,list,full
set wildmenu
" reload the .vimrc after saving changes to it
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" Jump to the last cursor position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif
" Let the explore mode (file tree) be in NERDTree style
let g:netrw_liststyle=3 
" mouse interoperability
set mouse=a

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
" make opening the .vimrc easier
nnoremap <leader>ev :e $MYVIMRC<CR>
" setting the pastetoggle
set pastetoggle=<c-p>

" VUNDLE
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
"Plugin 'python-mode/python-mode'
Plugin 'vim-latex/vim-latex'
Plugin 'tpope/vim-surround'
Plugin 'bfredl/nvim-ipy'
"Plugin 'davidhalter/jedi-vim'
" Plugin 'Shougo/deoplete.nvim'
" Plugin 'zchee/deoplete-jedi'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'gcmt/taboo.vim'
Plugin 'fs111/pydoc.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'mileszs/ack.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'lifepillar/vim-solarized8'
Plugin 'frankier/neovim-colors-solarized-truecolor-only'
call vundle#end()

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
" let latex suite ignore warnings from the tex compiler
let g:Tex_IgnoredWarnings = 
	\'Font Warning'."\n"
let g:Tex_IgnoreLevel = 8

" IPYTHON
let g:nvim_ipy_perform_mappings = 0
map <silent> <c-h> <Plug>(IPy-Run)
" run entire buffer with Ipython plugin
"map <silent> ra <esc>ggVGrr<c-o>
" terminate kernel
map <silent> <c-k> <Plug>(IPy-Terminate)

" NEOVIM
" specifically for neovim:
if has('nvim')
	" go to normal mode with jk while in terminal
	:tnoremap jk <C-\><C-n>
	let g:python_host_prog = '/usr/bin/python'
	let g:python3_host_prog = '/home/maltimore/miniconda3/bin/python'
"	let g:python3_host_prog = '/home/maltimore/miniconda3/envs/py35/bin/python'
	let g:loaded_python_provider = 1
endif


" DEOPLETE
" :let g:deoplete#enable_at_startup = 1
" inoremap <silent><expr> <Tab>
" \ pumvisible() ? "\<C-n>" :
" \ deoplete#mappings#manual_complete()

" VIM-SESSION
" let the vim-session plugin not ask to save/load every session
:let g:session_autoload = "no"
:let g:session_autosave = 'no'

" Markdown previewer
" note: hotkey for viewing is <c-p>
let vim_markdown_preview_github=1

" neovim-colors-solarized-truecolor-only plugin
set termguicolors
set background=dark " or dark
colorscheme solarized
