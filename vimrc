" disable x11 clipboard
set clipboard=exclude:.*

set encoding=utf-8

" disable bells
set noerrorbells
set novisualbell

" color theme
colorscheme desert

set nocompatible

" Vundle plugin manager
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Plugins from GitHub 
Plugin 'bling/vim-bufferline'
Plugin 'vim-airline/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'rhysd/vim-clang-format'
Plugin 'rking/ag.vim'
Plugin 'WolfgangMehner/c-support'
Plugin 'fatih/vim-go'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'nvie/vim-flake8'

" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'winmanager'

" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

filetype on

"" plugin settings
" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
let g:tagbar_left = 0
nmap <silent> <F3> :TagbarToggle<CR>

" ctrlp
let g:ctrlp_cmd = 'CtrlPMRU'
if executable('ag')
	let g:ctrlp_user_command = 'ag %s -l --nocolor g ""'
endif
let g:ctrlp_clear_cache_on_exit = 0

" NERDtree
"let g:NERDTreeKeyMap='<F4>'
nmap <silent> <F2> :NERDTreeToggle<CR>

" clang-format
let g:clang_format#detect_style_file=1
let g:clang_format#code_style="google"
let g:clang_format#style_options = {
        \ "BasedOnStyle": "Google",
        \ "IndentWidth" : 4}

function SetupCppEnv ()
    set number      " 显示行号
    set expandtab   " 展开TAB
    let g:clang_format#auto_format_on_insert_leave=1

    " map to <Leader>cf in C++ code
    nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
    vnoremap <buffer><Leader>cf :ClangFormat<CR>

    " if you install vim-operator-user
    map <buffer><Leader>x <Plug>(operator-clang-format)

    " Toggle auto formatting:
    nmap <Leader>C :ClangFormatAutoToggle<CR>
    " TAB键格式化选中区域
    "vmap <TAB> :ClangFormat<CR>
    " 普通模式下TAB键格式化当前行
    "nmap <TAB> :ClangFormat<CR>

    " auto enable clang-format
    ClangFormatAutoEnable

	" c-support
	" let g:C_CustomTemplateFile="~/.vim/c_templates/Templates"

endfunction

autocmd FileType c,cpp,cc,h,hpp call SetupCppEnv()

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1

function SetupGoEnv ()
endfunction

autocmd FileType go call SetupGoEnv()

function SetupPyEnv ()
	set tabstop=4
	set softtabstop=4
	set shiftwidth=4
	set textwidth=79
	set expandtab
	set autoindent
	set fileformat=unix
	"match BadWhitespace /\s\+$/
	set number
	"let python_highlight_all=1
endfunction

au BufNewFile,BufRead *.py call SetupPyEnv()

" silver searcher
let g:ag_working_path_mode="r"

" restore last position
if has("autocmd")
    au BufReadPost * if line("'\'") > 0 && line("'\'") <= line("$")
        \|exe "normal g'\"" |endif
endif

" alwyas display status line, for bufferline
set laststatus=2

" no backup files
set nobackup
set nowb

syntax on
nnoremap <F6> :set nonumber!<CR>:set foldcolumn=0<CR>
set showmatch

" editing settings
"set paste
set backspace=2
set shiftwidth=4
set tabstop=4
set smarttab
"set softtabstop=4

" indent settiongs
set autoindent
set smartindent
set cindent
set cinoptions=:0,g0,t0,(0,Ws,m1

" search settings
set hlsearch
set incsearch
set ignorecase
set smartcase

