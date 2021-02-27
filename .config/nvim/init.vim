" OPTIONS
" set tabstop width etc.
:set tabstop=4 softtabstop=0 shiftwidth=0 expandtab
" when opening a new file and typing the filename, this will give
" more bashlike behavior on hitting <tab>
set wildmode=longest,list,full
set wildmenu
" Jump to the last cursor position when reopening a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
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
" do not show the docstring window on completion. I do not want this because
" when the docstring window pops up, everything else is moved down. To show
" the docstring window, need to (also) select preview here
" (comma separated list)
set completeopt=menuone,noinsert,noselect
" go to insert mode when creating or switching to terminal buffer
autocmd TermOpen,BufWinEnter * if &buftype == 'terminal' | startinsert | endif
" highlight the current line
set cursorline
" always show n lines above/below cursor (unless impossible when at
" beginning/end of file)
set scrolloff=10
" line numbers
set number
" when using { and }, do not open folds when jumping over them
set foldopen-=block
" no line numbering in terminal
au TermOpen * setlocal nonumber norelativenumber
" get a python debugger (pdb) - compatible representation of the current
" cursor position into the clipboard. For instance src/main.py:26
nnoremap <Leader>y :let @*=expand("%") . ':' . line(".")<CR>
" write the python debugger (pdb) - compatible representation of the current
" cursor position into a file /tmp/.pdbpreak
nnoremap <Leader>t :call writefile(split('b ' . expand('%') . ':' . line("."), '\n'), '/tmp/.pdbreak')<CR>

" NEOVIM
" specifically for neovim:
if has('nvim')
	" use 24 bit color
	set termguicolors
	" go to normal mode with jk while in terminal
	:tnoremap jk <C-\><C-n>
	let g:python3_host_prog = $HOME . '/miniconda3/bin/python'
	" disable python 2 support
	let g:loaded_python_provider = 0
    " scrollback buffer of nvim terminal
	let g:scrollback = -1  " -1 means 'really much'
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " LSP config
    " go to where the function/class has been implemented
    nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
    " Open the docstring in a hover window
    nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
    " we want to be able to show the signature help in both normal
    " and insert mode
    inoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
    " get a quickfix window with all files/lines that reference the symbol under
    " the cursor
    nnoremap <silent> gR    <cmd>lua vim.lsp.buf.references()<CR>
    " rename all symbols that correspond to the one under the cursor
    nnoremap <silent> gr <cmd>lua vim.lsp.buf.rename()<CR>
    """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
endif

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
" This unsets the 'last search pattern' register by hitting return
" the last ':<backspace>' is just for ':noh' not showing up in
" the command line
nnoremap <CR> :noh<CR><CR>:<backspace>
" Map backspace to switch to the alternate buffer
nnoremap <BS> <C-^>

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
"Plug 'lifepillar/vim-solarized8'
" supertab is somehow necessary for the completions or doc windows
Plug 'ervandew/supertab'
" (Python) code lint
Plug 'neomake/neomake'
" Python code folding
Plug 'tmhedberg/SimpylFold'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jceb/vim-orgmode'
Plug 'lervag/vimtex'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'morhetz/gruvbox'
Plug 'neovim/nvim-lspconfig'
call plug#end()

" Markdown previewer
" note: hotkey for viewing is <c-p>
let vim_markdown_preview_github=1

" SYNTAX HIGHLIGHTING
" vim-solarized8
set background=dark
"colorscheme solarized8_low
autocmd vimenter * ++nested colorscheme gruvbox
let gruvbox_contrast_dark="medium"

" ACK.VIM
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Supertab
" move through the completion options top to bottom
let g:SuperTabContextDefaultCompletionType = "<c-n>"
" determine how to complete based on the word before the cursor
let g:SuperTabDefaultCompletionType = "context"
" close the preview window (with docstring) after completion
let g:SuperTabClosePreviewOnPopupClose = 1

" NEOMAKE
let g:neomake_python_flake8_maker = {
	\ 'exe': $HOME . '/miniconda3/bin/flake8',
    \ 'errorformat':
        \ '%E%f:%l: could not compile,%-Z%p^,' .
        \ '%A%f:%l:%c: %t%n %m,' .
        \ '%A%f:%l: %t%n %m,' .
        \ '%-G%.%#',
    \ }
let g:neomake_python_enabled_makers = ['flake8']
" run :Neomake every time I save or open a file
autocmd! BufWritePost,BufEnter * Neomake

" vim-tex
let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled=1

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "python", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
}
EOF


" nvim-lspconfig
" I'm not using palantir's python-language-server because it has multiple
" problems that don't seem to get fixed by the developer. Biggest issue is
" that it doesn't properly load flake8 configuration
lua << EOF
--local lspconfig = require'lspconfig'
--lspconfig.pyls.setup{
--  config = {
--    name = 'palantir';
--    settings = {
--      pyls = {
--        configurationSources = [[ 'flake8' ]];
--        plugins = {
--          mccabe = { enabled =  false};
--          pycodestyle = { enabled = false};
--          pyling = { enabled = false};
--        };
--      };
--    };
--  };
--}
require'lspconfig'.jedi_language_server.setup{}
EOF
