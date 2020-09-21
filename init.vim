""" Neovim configuration file
""" Author: Pedro Augusto Santana 
""" Version: 2

call plug#begin('~/.config/nvim/autoload/plugged/')
	Plug 'morhetz/gruvbox' " Colorscheme
    Plug 'itchyny/lightline.vim' " Statusline
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim', {'on':['Files','Ag','FZF']} " File searching
    Plug 'sheerun/vim-polyglot' " Syntax definitions
    Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense and autocompletion
    Plug 'mhinz/vim-signify' " Git integration
    Plug 'jiangmiao/auto-pairs' " Autoclosing
    Plug 'mg979/vim-visual-multi', {'branch': 'master'} " Multiple cursors
    Plug 'alvan/vim-closetag',{'for':['html','xml','htm','xhtml','.js','.jsx']} " Html autoclosing
    Plug 'mbbill/undotree' " Undo visualization
    Plug 'preservim/nerdtree',{'on':'NERDTreeToggle'}
    Plug 'Xuyuanp/nerdtree-git-plugin', {'for':'nerdtree'} " Git integration
    Plug 'preservim/nerdcommenter' " Autocomment lines
    Plug 'junegunn/goyo.vim', {'for':'markdown'} " Distraction free markdown
    Plug 'tpope/vim-fugitive' " Nice git integration
    Plug 'mattn/emmet-vim', {'for':['html','js','jsx']}" Emmet
call plug#end()

"" --- Basic Settings ---
set title
set noswapfile
set autochdir
set hidden
set termguicolors
set number
set relativenumber
set incsearch
set tabstop=4 shiftwidth=4
set expandtab
set splitright splitbelow
set linebreak
set mouse+=a
set clipboard+=unnamedplus
set noshowmode
set scrolloff=3
set ignorecase
set smartcase
set signcolumn=yes
set backspace=indent,eol,start

"" --- Visual ---

set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_invert_selection = '0'
colorscheme gruvbox


"" --- Lightline ---
let g:lightline = { 'colorscheme':'gruvbox' }


"" --- Keyboard shortcuts ---
let mapleader = " "
nnoremap <silent> + <C-a>
nnoremap <silent> - <C-x>
nnoremap <silent> <S-Tab> <<
inoremap <silent> <S-Tab> <C-d>
vmap <silent> <S-Tab> <

"" Tab completion
inoremap <silent> <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <silent> <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"
nnoremap <C-a> ggVG
nmap <C-s> :w<CR>

" Move lines
nnoremap <silent> <A-Up> :m-2<CR>==
nnoremap <silent> <A-Down> :m+<CR>==
inoremap <silent> <A-Up> <Esc>:m-2<CR>==gi
inoremap <silent> <A-Down> <Esc>:m+<CR>==gi
vnoremap <silent> <A-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <A-Down> :m '>+1<CR>gv=gv

" Better navigation on wrapped lines
map <silent> <Up> gk
imap <silent> <Up> <C-o>gk
map <silent> <Down> gj
imap <silent> <Down> <C-o>gj

"" --- NERDTree ---
map <silent> <C-b> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeGitStatusUseNerdFonts = 1
"" --- FZF ---
nmap <C-p> :Files<CR>
nnoremap <C-f> :Ag<CR>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

"" --- Coc ---
let g:coc_start_at_startup = 0
autocmd BufReadPre,FileReadPre * :CocStart

"" --- UndoTree ---
nnoremap <silent> <F5> :UndotreeToggle \| :UndotreeFocus<CR>

"" --- nerdcommenter ---
let g:NERDCommentEmptyLines = 1
let g:NERDSpaceDelims = 1
"" --- Emmet ----
let g:user_emmet_leader_key = ","


