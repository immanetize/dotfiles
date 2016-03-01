"
" $HOME/.vimrc -- a configuration file for Vi IMproved
"
"python from powerline.vim import setup as powerline_setup
"python powerline_setup()
"python del powerline_setup
set laststatus=2
set t_Co=256
" General settings:
set nocompatible                  " Disable Vi-compatible mode.
set magic                         " Use classic regular expressions.
set noignorecase                  " Be case sensitive.
set wrapscan                      " Search across multiple lines.
set backupcopy=no                 " Do not create backup copies.
set formatoptions=tcqr            " Adjust automatic formatting.
set backspace=indent,eol,start    " Specify the backspace behavior.
set history=1000                  " Specify the number of possible undos.
set helplang=en                   " Specify the help language.
set spelllang=en_us               " Specify the spell checking language.
set nospell                       " Disable spell checking by default.
filetype on                       " Enable file type detection.
filetype plugin indent on         " Enable automatic indentation.

" Environment settings:
set ruler                         " Display the ruler.
set showcmd                       " Display commands.
set showmode                      " Display the current mode.
set number                        " Display line numbers.
set hlsearch                      " Highlight all matching patterns.
set incsearch                     " Highlight matching text while typing.
syntax on                         " Highlight the syntax.

" Editing settings:
set textwidth=0                   " Do not set the default text width.
set wrap                          " Wrap the displayed text.
set linebreak                     " Break lines at a word boundary.
set expandtab                     " Replace tabulators with spaces.
set tabstop=2                     " Set the number of spaces for a tabulator.
set shiftwidth=2                  " Set the number of spaces for indentation.
set autoindent                    " Automatically insert line breaks.
set nojoinspaces                  " Do not insert a second space after
                                  " a sentence when joining lines.
" Configure the Vundle plug-in manager:
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
call vundle#begin()

" Configure bundles:
Bundle 'gmarik/vundle'
Bundle 'SirVer/ultisnips'
Bundle 'scrooloose/nerdtree'
Bundle 'majutsushi/tagbar'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-pandoc/vim-pandoc'
Bundle 'jhradilek/vim-docbk'
Bundle 'jhradilek/vim-mallard'
Bundle 'jhradilek/vim-pressgang'
Bundle 'jhradilek/vim-rng'
Bundle 'jhradilek/vim-snippets'
Bundle 'raichoo/haskell-vim'
Plugin 'chase/vim-ansible-yaml'
Bundle 'PProvost/vim-ps1'

" Enhance the vertical movement over wrapped text:
noremap k gk
noremap j gj
noremap <Up> g<Up>
noremap <Down> g<Down>
inoremap <Up> <Esc>g<Up>a
inoremap <Down> <Esc>g<Down>a

" Customize keyboard mapping:
nmap <F9> :make<CR>
imap <F9> <ESC>:make<CR>
cmap <F9> <ESC>:make<CR>

" Customize file type recognition:
au BufNewFile,BufRead *.rng set ft=rng
au BufNewFile,BufRead *.page set ft=mallard
au BufNewFile,BufRead *.page.stub set ft=mallard
au BufNewFile,BufRead *.contentspec set ft=contentspec
au FileType pandoc set ts=4 sw=4 expandtab
au FileType python set ts=4 sw=4 expandtab

" Configure the UltiSnips plug-in:
let g:UltiSnipsEditSplit = 'vertical'
let g:UltiSnipsExpandTrigger = '<s-tab>'
let g:UltiSnipsJumpForwardTrigger = '<s-tab>'
let g:UltiSnipsJumpBackwardTrigger = '<c-s-tab>'

" Configure the NERDTree plug-in:
let g:NERDTreeWinPos = 'left'     " Place the window to the left.
let g:NERDTreeWinSize = 25        " Change the window width.
nmap <silent> <F11> :NERDTreeToggle<CR>
imap <silent> <F11> <ESC>:NERDTreeToggle<CR>
cmap <silent> <F11> <ESC>:NERDTreeToggle<CR>

" Configure the Tagbar plug-in:
let g:tagbar_left = 0             " Place the window to the right.
let g:tagbar_width = 40           " Change the window width.
nmap <silent> <F12> :TagbarToggle<CR>
imap <silent> <F12> <ESC>:TagbarToggle<CR>
cmap <silent> <F12> <ESC>:TagbarToggle<CR>
"BEGIN_DEVASSISTANT_1
"Setting value devassistant to 0 will use your existing .vimrc file
"Setting value devassistant to 1 will use the vimrc defined by the devassistant feature

let devassistant=0
if devassistant==1
 :source /usr/share/devassistant/files/snippets/vim/vimrc
endif
"END_DEVASSISTANT_1

"stuff for ps1

:let g:ps1_nofold_blocks = 1
:let g:ps1_nofold_sig = 1

