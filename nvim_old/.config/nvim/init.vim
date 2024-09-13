" Auto-install VimPlug "
let s:plugpath = '~/.local/share/nvim/site/autoload/plug.vim'
if empty(glob(s:plugpath))
  echom "Installing vim-plug at " . s:plugpath
  exe "silent !curl -fLo " . s:plugpath . " --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" << (Neo)vim settings >> "

" Encoding and format
  set fileencoding=utf-8
  set fileencodings=ucs-bom,utf-8,gbk,cp936,latin-1
  set fileformat=unix
  set fileformats=unix,dos,mac

" Looks
  set colorcolumn=80    " Use a color column on the 80-character mark
  hi ColorColumn ctermbg=lightcyan
  set cursorline        "highlight the line of the cursor

" Enable hybrid (ralative and absolute) line numbers and auto switching
  set number relativenumber
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
  augroup END

" Show whitspace characters
  set showbreak=↪\
  set list listchars=tab:→\ ,nbsp:␣,trail:∙,extends:⟩,precedes:⟨
   "set listchars+=eol:↲
   "set listchars+=space:·

" useful settings
  set smartindent
  set expandtab             "tabs to spaces
  set tabstop=2             "width of tab
  set shiftwidth=2          "width of indent
  set foldmethod=indent     "folding by indent
  set foldlevel=99
  set ignorecase            "ignore the case when search texts
  set smartcase             "if searching text contains uppercase case will not be ignored

" Enable mouse mode
  set mouse=a

" Use the system clipboard
  set clipboard=unnamed

" Force saving files that require root permission
  cnoremap w!! w !sudo tee > /dev/null %

" Save history files in ~/.cache/nvim
  let g:netrw_home=$XDA_CACHE_HOME.'/nvim'

" Exit built in terminal
  tnoremap <Esc> <C-\><C-n>

" Plugin Settings

  " Airline
    " let g:airline#extensions#whitespace#enabled = 0
    let g:airline_powerline_fonts = 1
    " Disable defualt mode indicator (in favor of airline)
    set noshowmode
    let g:airline#extensions#tabline#enabled = 1
    "colorscheme gruvbox
    let g:airline_theme = 'base16_default'
    " Change clock format
    let g:airline#extensions#clock#format = '%l:%M %p'

  " Devicons
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

  " Deoplete
    " Enable autocomplete on startup
    let g:deoplete#enable_at_startup=1
    " Fix deoplete python version
    let g:deoplete#sources#jedi#python_path = 'python3'
    " Make the method preview window automatically disappear
    autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
    " Navigate through suggestions with <TAB>
    inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

  " NeoFormat
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

    " Syntax highlight .rofi files (rofi menu)
    au BufNewFile,BufRead /*.rasi setf css
  " Startify
    " returns all modified files of the current git repo
    " `2>/dev/null` makes the command fail quietly, so that when we are not
    " in a git repo, the list will be empty
    function! s:gitModified()
        let files = systemlist('git ls-files -m 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
    endfunction

    " same as above, but show untracked files, honouring .gitignore
    function! s:gitUntracked()
        let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
        return map(files, "{'line': v:val, 'path': v:val}")
    endfunction

    let g:startify_lists = [
            \ { 'type': 'files',     'header': ['  Recent']            },
            \ { 'type': 'dir',       'header': ['   Recent in '. getcwd()] },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': function('s:gitModified'),  'header': ['   Git Modified']},
            \ { 'type': function('s:gitUntracked'), 'header': ['   Git Untracked']},
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]
    let g:startify_commands = [
        \ {'h':'h ref'},
        \ {'c':'e $MYVIMRC' },]
" Plugins will be downloaded under the specified directory.
call plug#begin('~/.local/share/nvim/plugged')

" Bar Color schemes
  Plug 'vim-airline/vim-airline-themes'
" Python autocomplete
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'zchee/deoplete-jedi'
" Code formater
  Plug 'sbdchd/neoformat'
" Highlight copied regions
  Plug 'machakann/vim-highlightedyank'
" Color scheme
  " Plug 'joshdick/onedark.vim'
  Plug 'morhetz/gruvbox'
" Comment `gcc`
  Plug 'tpope/vim-commentary'
" Bracket/quote autocomplete
  Plug 'jiangmiao/auto-pairs'
" Status bar
  Plug 'vim-airline/vim-airline'
  Plug 'enricobacis/vim-airline-clock'
" Git plugin (:G)
  Plug 'tpope/vim-fugitive'
" nnn file browser
  Plug 'mcchrish/nnn.vim'
" Sidebar diff
  "TODO
  "Plug 'airblade/vim-gitgutter'
" File icons
  " Plug 'ryanoasis/vim-devicons'
" Start splash screen
  Plug 'mhinz/vim-startify'
call plug#end()
