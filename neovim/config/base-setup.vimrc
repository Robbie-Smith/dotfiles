au BufEnter,BufLeave * :nohlsearch
"****************
" Basic Setup
"****************
" Encoding
set encoding=utf-8
" Enable hidden buffers
set hidden
" Number of undo levels
set undolevels=1000
set undodir=~/.config/nvim/undodir
set undofile
" Set updatetime
set updatetime=500
" Directories for swp files
set nobackup
set noswapfile
filetype plugin indent on
set clipboard=unnamed
set mouse=a
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite
" Map the leader key to SPACE
let mapleader="\<SPACE>"
" Use ; for commands
nnoremap ; :
"****************
" Indenting
"****************
" Fix backspace indent
" Tabs. May be overriten by autocmd rules
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set autoindent
set smartindent
set showcmd
"****************
" Searching
"****************
set hlsearch  " Highlight all search results
set smartcase " Enable smart-case search
set ignorecase  " Always case-insensitive
set incsearch " Searches for strings incrementally
"****************
" Visual Settings
"****************
" Highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
syntax on
syntax enable
set ruler
set number

" Tell the term has 256 colors
if (has("termguicolors"))
  set termguicolors
endif
"****************
" Color Scheme
"****************
set background=dark
" colorscheme base16-tomorrow-night
colorscheme gruvbox
"****************
" Highlighting
"****************
hi LineNr guifg=String guibg=bg
hi IncSearch guibg=#66cccc
hi SignColumn guibg=bg
hi ALEErrorSign gui=bold guifg=#fb4934 guibg=bg
hi ALEWarningSign gui=bold guifg=#60ff60 guibg=bg
hi NeomakeErrorSign guibg=bg
hi NeomakeWarningSign guibg=bg
hi GitGutterAdd gui=bold guifg=#8ec07c guibg=bg
" hi GitGutterChangeDelete gui=bold guifg=#fb4934 guibg=bg
hi GitGutterDelete gui=bold guifg=#fb4934 guibg=bg
hi GitGutterChange gui=bold guifg=#fabd2f guibg=bg
hi GitGutterAddLine gui=bold guifg=#8ec07c guibg=bg
hi MatchParen gui=bold guifg=#66cccc