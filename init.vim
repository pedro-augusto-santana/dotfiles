"" Pedro Augusto Santana
" Vim (Neovim) settings for my personal use,
" programming and note taking.

""" Plugins
call plug#begin('~/.config/nvim/autoload/plugged/')
	" Visual
	Plug 'morhetz/gruvbox' " Colorscheme
	" Plugins
	Plug 'neoclide/coc.nvim', {'branch': 'release'} " Autocompletion provider
	Plug 'vim-airline/vim-airline' " Statusline
	Plug 'vim-airline/vim-airline-themes' "Statusline themes
	Plug 'preservim/nerdtree', {'on' : 'NERDTreeToggle'} | " File explorer
				\ Plug 'Xuyuanp/nerdtree-git-plugin' " File explorer git integration
	Plug 'mbbill/undotree', {'on': 'UndotreeToggle'} " Undo visualization
	Plug 'preservim/nerdcommenter' " Quick line comment
	Plug 'mg979/vim-visual-multi' " Sublime Text like multiple cursors
	Plug 'jiangmiao/auto-pairs' " Autoclose pairs of characters
	Plug 'sheerun/vim-polyglot' " Better syntax definition
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " Fuzzy file searching
	Plug 'junegunn/fzf.vim'
	Plug 'machakann/vim-sandwich' " Wrap around
	Plug 'tpope/vim-fugitive' " Git wrapper
	Plug 'ryanoasis/vim-devicons' " Icons for file explorer
	Plug 'mhinz/vim-signify' " Git gutter indicator

	" Markdown editing
	Plug 'junegunn/goyo.vim', {'for': 'markdown'} " Distraction free markdown editing
	Plug 'dkarter/bullets.vim', {'for': 'markdown'} " Better markdown list rendering
	Plug 'mattn/emmet-vim' " Emmet
call plug#end()

""" Basic settings
set hidden
set nocursorline
set encoding=utf-8
set signcolumn=yes
set number
set relativenumber
set incsearch
set mouse=a
set background=dark
set clipboard+=unnamedplus
set tabstop=4
set shiftwidth=4
set ruler
set smarttab
set ignorecase
set smartcase
set showmatch
set inccommand=split
set completeopt=longest,menu
set linebreak
set splitright
set scrolloff=2

let gruvbox_contrast_dark='hard'
let gruvbox_invert_selection = '0'
colorscheme gruvbox


let mapleader="\<Space>"
tnoremap <Esc> <C-\><C-n>
nmap <silent> <leader> :call CocActionAsync("jumpDefinition")<CR>
nnoremap <silent> K :call CocAction('doHover')<CR>

" Project rename
nmap <F2> <Plug>(coc-rename)
nmap <leader>pr :CocSearch <C-R>=expand("<cword>")<CR><CR>

nnoremap <silent> <leader>n :bn<CR>
nnoremap <silent> <leader>b :bp<CR>

nnoremap <C-s> :write<CR>
inoremap <S-Tab> <C-d>
nnoremap <S-Tab> <C-d>
inoremap <C-Bs> <C-W>
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <C-f> :Ag<CR>

"" Move lines
nnoremap <silent> <A-Up> :m-2<CR>==
nnoremap <silent> <A-Down> :m+<CR>==
inoremap <silent> <A-Up> <Esc>:m-2<CR>==gi
inoremap <silent> <A-Down> <Esc>:m+<CR>==gi
vnoremap <silent> <A-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <A-Down> :m '>+1<CR>gv=gv

""" NERDTree
let g:NERDTreeWinSize = 30
map <silent> <C-b> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeIgnore = ["^node_modules$[[dir]]"] " Ignore 'node_modules' directory

""" Open undotree
nnoremap <silent> <F5> :UndotreeToggle \| :UndotreeFocus<CR>

" Airline
let g:airline#extensions#tabline#enabled = 1 " enable airline tabline
let g:airline#extensions#tabline#show_close_button = 0 " remove 'X' at the end of the tabline

" nerdcommenter
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDSpaceDelims = 1

" FZF / AG file search close on <ESC>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" Goyo configuration
let g:goyo_height = '90%'
let g:goyo_width = '80%'

" Activate Goyo on markdown files
autocmd FileType markdown nnoremap <silent> <C-G> :Goyo<CR>


