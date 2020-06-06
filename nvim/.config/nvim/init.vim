" << PERSONAL SETTINGS >> "
" TEST
" Enable line numbers
:set number
" UTF-8 support
:set encoding=utf-8
:setglobal fileencoding=utf-8
" Show whitspace characters
set showbreak=↪\
set list listchars=tab:│.,nbsp:␣,trail:∙,extends:⟩,precedes:⟨
set listchars+=eol:↲
" set listchars+=space:·
" configure tab options
set tabstop=8 shiftwidth=8 noexpandtab
" Force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %

" << BEGIN PLUGIN SETTINGS >> "
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Declare the list of plugins.
"Plug 'tpope/vim-sensible'
"Plug 'junegunn/seoul256.vim'

" Python autocomplete
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
" Code formater
Plug 'sbdchd/neoformat'
" Highlight copied regions
Plug 'machakann/vim-highlightedyank'
" Color scheme
Plug 'morhetz/gruvbox'
" Comment \c<space>
Plug 'scrooloose/nerdcommenter'
" File sidebar
Plug 'scrooloose/nerdtree'
" Bracket/quote autocomplete
Plug 'jiangmiao/auto-pairs'
" Status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'
" Git plugin (:G)
Plug 'tpope/vim-fugitive'
" File icons
Plug 'ryanoasis/vim-devicons'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" <<DEV-ICONS GLYPHS>> "
" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1
" add or override individual filetypes
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols = {}
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ttf'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['ino'] = ''
let g:WebDevIconsUnicodeDecorateFileNodesExtensionSymbols['mp3'] = ''

let g:WebDevIconsOS = 'Linux'
" Enable autocomplete on startup
let g:deoplete#enable_at_startup=1
" Fix deoplete python version
let g:deoplete#sources#jedi#python_path = 'python3'
" Make the method preview window automatically disappear
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" Navigate through suggestions with <TAB>
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" CODE FORMATTING
let g:neoformat_enabled_python = ['autopep8']
" Format on save
"augroup fmt
"	autocmd!
"	autocmd BufWritePre * undojoin | Neoformat
" augroup END
" Enable alignment
let g:neoformat_basic_format_align = 1

" Enable tab to spaces conversion
let g:neoformat_basic_format_retab = 1

" Enable trimmming of trailing whitespace
let g:neoformat_basic_format_trim = 1

" set highlight duration time to 1000 ms, i.e., 1 second
let g:highlightedyank_highlight_duration = 1000

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" File tree filters
let NERDTreeIgnore=['__pycache__[[dir]]']

" << AIRLINE CONFIGURATION >> "
" let g:airline#extensions#whitespace#enabled = 0
" Enable powerline statusbar
let g:airline_powerline_fonts = 1
" Disable defualt mode indicator (in favor of airline)
set noshowmode
let g:airline#extensions#tabline#enabled = 1
colorscheme gruvbox
let g:airline_theme = 'base16_gruvbox_dark_hard'

" let g:airline_statusline_ontop = 1
" Change clock format
let g:airline#extensions#clock#format = '%l:%M %p'
" Syntax highlight .rofi files (rofi menu)
au BufNewFile,BufRead /*.rasi setf css
