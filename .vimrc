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
" make searching case insensitive when search string is only lowercase
set ignorecase
set smartcase
" use 24 bit color
if has('nvim')
	set termguicolors
endif
" jump to other windows when switching buffers
set switchbuf=useopen,usetab
" some plugins tries to remap the :E command, here we get it back
if !exists(":E")
	command E Ex
endif
" open help in an [only] window
autocmd FileType help on
" highlight search
set hlsearch
" search as you type
set incsearch
" make it possible to make an unwritten buffer hidden
set hidden

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

" VUNDLE
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'vim-latex/vim-latex'
Plugin 'tpope/vim-surround'
" Plugin 'bfredl/nvim-ipy'
Plugin 'davidhalter/jedi-vim'
" Plugin 'Shougo/deoplete.nvim'
" Plugin 'zchee/deoplete-jedi'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-scripts/IndexedSearch'
Plugin 'gcmt/taboo.vim'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
Plugin 'mileszs/ack.vim'
Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'neomake/neomake'
Plugin 'lifepillar/vim-solarized8'
Plugin 'frankier/neovim-colors-solarized-truecolor-only'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'heavenshell/vim-pydocstring'
Plugin 'junegunn/vim-easy-align'
Plugin 'Yggdroot/indentLine'
call vundle#end()

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
"let g:nvim_ipy_perform_mappings = 0
"map <silent> <c-h> <Plug>(IPy-Run)
" run entire buffer with Ipython plugin
"map <silent> ra <esc>ggVGrr<c-o>
" terminate kernel
"map <silent> <c-k> <Plug>(IPy-Terminate)

" NEOVIM
" specifically for neovim:
if has('nvim')
	" go to normal mode with jk while in terminal
	:tnoremap jk <C-\><C-n>
	let g:python_host_prog = '/usr/bin/python'
	let g:python3_host_prog = $HOME . '/miniconda3/envs/neovim_env/bin/python'
	" disable python 2 support
	let g:loaded_python_provider = 1

    " use neovims inccommand to highlight replacings
	" set inccommand=nosplit
	let g:terminal_scrollback_buffer_size = 100000
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

" SYNTAX HIGHLIGHTING
" neovim-colors-solarized-truecolor-only plugin
set background=dark " or dark
colorscheme solarized

" CtrlP (fuzzy file search)
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" VIM-EASY-ALIGN
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" JEDI-VIM
let g:jedi#force_py_version = 3
" jedi vim should not complete at all, I just want the other features
let g:jedi#completions_enabled = 0
" set the delay in ms until jedi-vim shows call signatures
let g:jedi#show_call_signatures_delay = 1000

" NEOMAKE
let g:neomake_python_flake8_maker = {
	\ 'exe': $HOME . '/miniconda3/envs/neovim_env/bin/flake8',
    \ 'args': ['--ignore=E111,E113,E126,E222,E266,E265,E402,E241,E201,E203,E999',  '--format=default', '--max-line-length=100'],
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }
let g:neomake_python_enabled_makers = ['flake8']
" run :Neomake every time I save or open a file
autocmd! BufWritePost,BufEnter * Neomake

" INDENTLINCE
" do not use for latex, markdown
let g:indentLine_fileTypeExclude = ['tex', 'markdown']
