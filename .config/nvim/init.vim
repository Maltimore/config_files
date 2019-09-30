" OPTIONS
" set tabstop width etc.
:set tabstop=4 softtabstop=4 shiftwidth=4 noexpandtab
" show line numbering
:set number
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
" make it possible to save with root rights
command! -nargs=0 Sw w !sudo tee % > /dev/null
" make it such that the preview window is opened below the current window
augroup PreviewOnBottom
    autocmd InsertEnter * set splitbelow
    autocmd InsertLeave * set splitbelow!
augroup END
" do not show the docstring window. To show the docstring window, need to
" (also) select preview here (comma separated list)
set completeopt=menu
" make it such that the mode is not shown in the command line
set noshowmode

" REMAPPING
" remap o so that it doesn't go to insert mode
:map o o<esc>
:map O O<esc>
" remap jk to exit insert mode
:imap jk <C-[>
" remap sl so that i can use it for the command to switch windows
:nmap sl <C-w>
" make it easier to comment lines in python
:vmap  # :s#^#\##<cr>:noh<cr>
:vmap -# :s#^\###<cr>:noh<cr>
" make opening the .vimrc easier
nnoremap <leader>ev :e $MYVIMRC<CR>
" close all preview windows with space
nnoremap <silent> <SPACE> :pc<CR>

" VIM-PLUG
" auto-install vim-plug if it isn't installed yet
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif
" vim-plug plugins
" Specify a directory for plugins
if has('nvim')
  call plug#begin('~/.local/share/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif
Plug 'vim-latex/vim-latex'
" Plug 'davidhalter/jedi-vim'
Plug 'vim-scripts/IndexedSearch'
Plug 'mileszs/ack.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'lifepillar/vim-solarized8'
" supertab is somehow necessary for the completions windows or
" doc windows
Plug 'ervandew/supertab'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
if has('nvim')
    Plug 'shougo/deoplete.nvim', {
        \ 'do': ':UpdateRemotePlugins',
        \ }
endif
Plug 'Shougo/echodoc.vim'
call plug#end()

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

" NEOVIM
" specifically for neovim:
if has('nvim')
	" use 24 bit color
	set termguicolors
	" go to normal mode with jk while in terminal
	:tnoremap jk <C-\><C-n>
	let g:python3_host_prog = $HOME . '/miniconda3/bin/python'
	" disable python 2 support
	let g:loaded_python_provider = 1

    " use neovims inccommand to highlight replacings
	" set inccommand=nosplit
	let g:terminal_scrollback_buffer_size = 100000
endif

" Markdown previewer
" note: hotkey for viewing is <c-p>
let vim_markdown_preview_github=1

" SYNTAX HIGHLIGHTING
" vim-solarized8
set background=dark
colorscheme solarized8

" CtrlP (fuzzy file search)
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" VIM-EASY-ALIGN
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" ACK.VIM
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Supertab
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/miniconda3/bin/pyls'],
    \ }
let g:LanguageClient_settingsPath = "~/.config/LanguageClient-neovim_LSP-server-settings.json"
" opens the documentation of the object under the cursor
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
" goes to the source code of the object under the cursor
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>

" deoplete
let g:deoplete#enable_at_startup = 1

" echodoc
let g:echodoc#enable_at_startup = 1
let g:echodoc#type = 'floating'
