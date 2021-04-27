" =============================
" NEOVIM CONFIGURATION FILE
"           2021
" =============================

set number " show line numbers
set hidden " enable hidden buffers
set termguicolors " true colors for terminal
set clipboard+=unnamedplus " use system clipboard
set autochdir " change cwd more easily
set noswapfile " disable swap files
set autoindent " indentation
set cindent " ''
set smartindent " ''
set inccommand=split " make split in search/sub
set cursorline " highlight current cursor line
set incsearch " incremental search
set tabstop=4 " set tabs as 4 spaces
set shiftwidth=4 " same thing for different commands
set scrolloff=2 " vertical scroll padding of 2 lines
set ignorecase " ignore case...
set smartcase " except if there is a uppercase character on string
set signcolumn=number " gutter is the same as number column on the right
set noshowmode " disable -- INSERT --  in the command line
set background=dark " REQUIRED
set mouse=a " use mouse
set updatetime=300 " reduce update time for cursor hold operations
set splitright splitbelow " splits open on the right and on the bottom
set shortmess+=c " show short/no messages to command line
set backspace=indent,eol,start " some backspace shit I don't remember
set whichwrap+=<,>,h,l,[,] " make cursor navigation wrap lines
set pumheight=12 " autocomplete menu max lin number == 12
set linebreak " word wrap

command Conf :e ~/.config/nvim/init.vim

" PLUGINS
call plug#begin('~/.config/nvim/plugged/')
Plug 'preservim/nerdtree' " file explrer
Plug 'neoclide/coc.nvim', { 'branch' : 'release' } " basically vscode
Plug 'itchyny/lightline.vim' " statusline
Plug 'sainnhe/gruvbox-material' " theme *chefs kiss*
Plug 'sheerun/vim-polyglot' " better + more syntax definitions
Plug 'preservim/nerdcommenter' " comments
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder + a lot of things
Plug 'junegunn/fzf.vim' " makes fzf work better
Plug 'romainl/vim-cool' " utility for search
Plug 'mg979/vim-visual-multi' " sublime-like multiple cursors
Plug 'APZelos/blamer.nvim' " codelens for git
"Plug 'liuchengxu/vista.vim' " outliner
Plug 'lambdalisue/gina.vim'
call plug#end()


" APPEARANCE
let g:gruvbox_material_background='hard'
let g:gruvbox_constrast_dark='hard'
let g:gruvbox_invert_selection=0
let g:gruvbox_material_pallete='mixed'
colorscheme gruvbox-material

" FILETYPE SYNTAX
autocmd FileType html,typescript,javascript,javascriptreact,typescriptreact setlocal shiftwidth=2 tabstop=2 " set indentation to two spaces

" NERDTREE
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
            \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif " replace netrw in directory arguments

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
            \ quit | endif " quit if the only window left is the file explorer

autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
            \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif " prevent nerdtree buffer being replaced

nnoremap <silent><C-b> :NERDTreeToggle<CR>

let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '~'
let g:NERDTreeIgnore = ['^node_modules$']
let g:NERDTreeWinPos = "right" " show on right side

" COC
" prompt autocomplete
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent><F2> <Plug>(coc-definition)
nmap <silent><F3> <Plug>(coc-references)
vnoremap <silent><leader>a <Plug>(coc-codeaction-selected)
nnoremap <silent><leader>a <Plug>(coc-codeaction-selected)

" show matches
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent><F12> <Plug>(coc-rename)
command! -nargs=0 Format :call CocAction('format')
nnoremap <silent><nowait> <space>dg  :<C-u>CocList diagnostics<cr>
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
autocmd VimLeave * if get(g:, 'coc_process_pid', 0) | call system('kill -9 -'.g:coc_process_pid) | endif
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" LIGHTLINE
set showtabline=2
let g:lightline = { 'colorscheme': 'gruvbox_material' }

" KEYBINDINGS
let mapleader=" "
" move lines arround using alt arrows
nnoremap <silent> <A-Up> :m-2<CR>==
nnoremap <silent> <A-Down> :m+<CR>==
vnoremap <silent> <A-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <A-Down> :m '>+1<CR>gv=gv
" select all - both are necessary
nnoremap <C-a> ggVG
vnoremap <C-a> ggVG
" shift tab unindent in insert mode
inoremap <S-Tab> <C-D>

" FZF / AG
let $FZF_DEFAULT_OPTS="--ansi --preview-window 'right:60%' --layout reverse --margin=1,4 --preview 'bat --color=always --style=header,grid --line-range :300 {}'"
" CTRL P search files
nnoremap <silent> <c-p> :Files<cr>
" CTRL F search text
nnoremap <silent> <c-f> :Ag<cr>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"
