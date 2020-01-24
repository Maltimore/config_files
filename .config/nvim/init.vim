" OPTIONS
" set tabstop width etc.
:set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
" when opening a new file and typing the filename, this will give
" more bashlike behavior on hitting <tab>
set wildmode=longest,list,full
set wildmenu
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

" REMAPPING
" remap jk to exit insert mode
:imap jk <C-[>
" remap s so that i can use it for the command to switch windows
:nmap s <C-w>
" make it easier to comment lines in python
:vmap  # :s#^#\##<cr>:noh<cr>
:vmap -# :s#^\###<cr>:noh<cr>
" make opening the .vimrc easier
nnoremap <leader>ev :e $MYVIMRC<CR>

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
Plug 'vim-scripts/IndexedSearch'
Plug 'mileszs/ack.vim'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'lifepillar/vim-solarized8'
" supertab is somehow necessary for the completions or doc windows
Plug 'ervandew/supertab'
call plug#end()

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

	let g:terminal_scrollback_buffer_size = 100000
endif

" Markdown previewer
" note: hotkey for viewing is <c-p>
let vim_markdown_preview_github=1

" SYNTAX HIGHLIGHTING
" vim-solarized8
set background=dark
colorscheme solarized8

" ACK.VIM
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Supertab
let g:SuperTabContextDefaultCompletionType = "<c-n>"
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabClosePreviewOnPopupClose = 1
