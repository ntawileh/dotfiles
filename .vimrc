if has("syntax")
  syntax on
endif


if &term =~ "xterm"
        set background=dark
endif

set autoindent
set cindent
set noswapfile
set smartindent
set splitbelow
set splitright
set shiftwidth=4
set tabstop=4
set nocompatible        " Disable vi compatibility.
set number
set nobackup            " Do not keep a backup file.
set history=100         " Number of lines of command line history.
set undolevels=200      " Number of undo levels.
set showcmd             " Show (partial) command in status line.
set showmatch           " Show matching brackets.
set showmode            " Show current mode.
set ruler               " Show the line and column numbers of the cursor.
set ignorecase          " Case insensitive matching.
set incsearch           " Incremental search.
set scrolloff=5         " Keep a context when scrolling.
set noerrorbells        " No beeps.
set modeline            " Enable modeline.
"set esckeys             " Cursor keys in insert mode.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).
set ttyscroll=0         " Turn off scrolling (this is faster).
set ttyfast             " We have a fast terminal connection.
set hlsearch            " Highlight search matches.
set foldenable
set foldmethod=marker

set nostartofline
set viminfo='20,\"50
set rtp+=/usr/local/opt/fzf

set re=0

nmap <F1> :set hls!<CR>
map <F4> :r !date<CR>A Nadim Tawileh <nadim@tawileh.com><CR><CR> * |

" Function to toggle line numbers using F10
let ln_mode = 0 " 0 = hidden, 1 = visible
func! Ln_on_off()
        if g:ln_mode == 0
                set nu
                let g:ln_mode = 1
        else
                set nonu
                let g:ln_mode = 0
        endif
        return
endfunc
map <F10> :call Ln_on_off()<CR>

" Plug stuff
"
if empty(glob('~/.vim/autoload/plug.vim'))
	silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
	 \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Plug 'sainnhe/vim-color-forest-night'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }


" Initialize plugin system
call plug#end()


colorscheme default "catppuccin_mocha
