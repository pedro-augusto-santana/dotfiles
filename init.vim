" NEOVIM CONFIGURATION FILE
" 2021

call plug#begin('~/.config/nvim/plugged/')
	Plug 'neoclide/coc.nvim', {'branch':'release'} " LSP
	Plug 'vimwiki/vimwiki' " magic
	Plug 'itchyny/lightline.vim' " statusline
	Plug 'itchyny/calendar.vim', {'on':'Calendar'} " vim calendar
	Plug 'mbbill/undotree', {'on':'UndotreeToggle'} " save undo history
	Plug 'junegunn/goyo.vim', {'for':['markdown','vimwiki'], 'on':'Goyo'} " better markdown writing
	Plug 'sheerun/vim-polyglot' " better + more syntax definitions
	Plug 'preservim/nerdcommenter' " comments
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } " fuzzy finder + a lot of things
	Plug 'junegunn/fzf.vim' " makes fzf work better
	Plug 'romainl/vim-cool' " utility for search
	Plug 'mg979/vim-visual-multi' " sublime-like multiple cursors
	Plug 'tpope/vim-fugitive' " git integration
	Plug 'preservim/nerdtree', {'on':'NERDTreeToggle'} " file explorer
	Plug 'sainnhe/gruvbox-material' " theme
	Plug 'lervag/vimtex', {'for':'tex'}
	Plug 'ryanoasis/vim-devicons' " nice icons
call plug#end()

" DEFAULT OPTIONS
set number " show line numbers
set numberwidth=5
set hidden " enable hidden buffers
set termguicolors " true colors for terminal
set clipboard+=unnamedplus " use system clipboard
set noswapfile " disable swap files
set autoindent " indentation
set cindent " ''
set smartindent " ''
set inccommand=split " make split in search/sub
set cursorline " highlight current cursor line
set incsearch " incremental search
set tabstop=4 " set tabs as 4 spaces
set shiftwidth=4 " same thing for different commands
set scrolloff=4 " vertical scroll padding of 4 lines
set ignorecase " ignore case...
set smartcase " ... except if there is a uppercase character on string
set signcolumn=number " gutter is the same as number column on the left
set noshowmode " disable -- INSERT --  in the command line
set background=dark " REQUIRED
set mouse=a " use mouse
set display+=lastline
set updatetime=300 " reduce update time for cursor hold operations
set splitright splitbelow " splits open on the right and on the bottom
set shortmess+=c " show short/no messages to command line
set backspace=indent,eol,start " some backspace shit I don't remember
set whichwrap+=<,>,h,l,[,] " make cursor navigation wrap lines
set pumheight=12 " autocomplete menu max lin number == 12
set linebreak " word wrap
"set backup " backup
"set backupdir=~/.config/nvim/backup " backup
set conceallevel=1
set nobackup
set nofoldenable " disable folding, i hate it

command Conf :e ~/.config/nvim/init.vim

set guifont=JetBrainsMono\ Nerd\ Font:h16

" THEMES
let g:gruvbox_material_background='hard'
let g:gruvbox_constrast_dark='hard'
let g:gruvbox_invert_selection=0
let g:gruvbox_material_pallete='original'
colorscheme gruvbox-material

"LIGHTLINE
set showtabline=2
let g:lightline = {'colorscheme':'gruvbox_material', 'tab_component_function': { 'tabnum': 'LightlineWebDevIcons' }}

function! LightlineWebDevIcons(n)
	let l:bufnr = tabpagebuflist(a:n)[tabpagewinnr(a:n) - 1]
	return WebDevIconsGetFileTypeSymbol(bufname(l:bufnr))
endfunction

" KEYBINDINGS
let mapleader=" "
nnoremap <silent><leader>tn :tabnew<CR>
nnoremap <silent><leader>tce :tabnew +Conf<CR>
" move lines arround using alt arrows
nnoremap <silent> <A-Up> :m-2<CR>==
nnoremap <silent> <A-Down> :m+<CR>==
vnoremap <silent> <A-Up> :m '<-2<CR>gv=gv
vnoremap <silent> <A-Down> :m '>+1<CR>gv=gv
nnoremap + <C-a>
nnoremap - <C-x>
" select all - both are necessary
nnoremap <C-a> ggVG
vnoremap <C-a> ggVG
inoremap <C-BS> <C-w>

" shift tab unindent in insert mode
inoremap <S-Tab> <C-D>

" better navigation trough wrapped lines (FUCKING GOLD)
noremap <expr> <Up> v:count==0 ? 'g<Up>' : '<Up>'
noremap <expr> <Down> v:count==0 ? 'g<Down>' : '<Down>'


" UNDOTREE
nnoremap <F6> :UndotreeToggle<CR>

" NERDTREE
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
			\ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif " replace netrw in directory arguments

autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
			\ quit | endif " quit if the only window left is the file explorer

autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
			\ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif " prevent nerdtree buffer being replaced

nnoremap <silent><C-b> :NERDTreeToggle<CR>
nnoremap <silent><leader>F :NERDTreeFind<CR>
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let g:NERDTreeIgnore = ['^node_modules$', '^.git$', '^__pycache__$']
"let g:NERDTreeWinPos = 'right' " show on right side
let g:NERDTreeRemoveFileCmd="gio trash "
let g:NERDTreeRemoveDirCmd="gio trash "
let g:NERDTreeMouseMode=2

" NERDCOMMENTER
let g:NERDCommentEmptyLines = 1

" FZF / AG
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline' ]}), <bang>0)

" CTRL P search files
nnoremap <silent> <c-p> :Files<cr>

nnoremap <silent><leader>B :Buffers<CR>

" CTRL F search text
nnoremap <silent> <c-f> :Ag<cr>
tnoremap <expr> <Esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

" DEVICONS
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {} " needed
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['pdf'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['zip'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['mp3'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['wiki'] = ''
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
let g:DevIconsEnableFoldersOpenClose = 1

" GOYO
autocmd FileType markdown,vimwiki nnoremap <buffer> <silent><leader>go :Goyo<CR>
let g:goyo_width = 175
let g:goyo_height = '95%'
"autocmd! User GoyoEnter Limelight
"autocmd! User GoyoLeave Limelight!

" VIMWIKI
let g:vimwiki_list = [{'path': '~/Notes/', 'syntax':'markdown','ext':'.md','diary_rel_path':'journal/'}]
let g:vimwiki_global_ext = 0
let g:vimwiki_ext2syntax = {".md":"markdown", ".markdown":"markdown",".mdown":"markdown"}
let g:vimwiki_markdown_link_ext = 1


au FileType vimwiki set syntax=markdown

" COC
" prompt autocomplete
inoremap <silent><expr> <c-space> coc#refresh()
nmap <silent><F2> <Plug>(coc-definition)
nmap <silent><F3> <Plug>(coc-references)
nmap <silent><A-l> :CocAction<cr>

" show matches
autocmd CursorHold * silent call CocActionAsync('highlight')

nmap <silent><F12> <Plug>(coc-rename)
command! -nargs=0 Format :call CocAction('format')
nnoremap <silent><nowait> <space>dg  :<C-u>CocList diagnostics<cr>
inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
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

" VIMTEX
let g:Tex_DefaultTargetFormat='pdf'
let g:vimtex_view_general_viewer = 'zathura'
