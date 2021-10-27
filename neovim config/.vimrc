set number
set mouse=a
set numberwidth=1
set clipboard=unnamed
syntax enable
set showcmd
set ruler
set encoding=utf-8
set showmatch
set sw=2
set cursorline

set laststatus=2
set noshowmode
set expandtab
set shiftwidth=4

set autoindent
set cindent

set splitbelow

call plug#begin('~/.vim/plugged')

" Temas
Plug 'morhetz/gruvbox'

" IDE
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdtree'
Plug 'christoomey/vim-tmux-navigator'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Raimondi/delimitMate'
Plug '907th/vim-auto-save'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'chemzqm/vim-jsx-improve'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'ap/vim-css-color'

call plug#end()

colorscheme gruvbox
let g:gruvbox_contrast_dark = "hard"
let NERDTreeQuitOnOpen=1
let g:auto_save=1
let g:auto_save_events = ["InsertLeave", "TextChanged"]
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-html']
let g:jsx_improve_javascriptreact = 0
let g:coc_filetype_map = {'js': 'typescriptreact'}

if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif

if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

let mapleader=" "

nmap <Leader>s <Plug>(easymotion-s2)
nmap <Leader>n :NERDTreeFind<CR>
nmap <Leader>w :w<CR>
nmap <Leader>q :q<CR>
nmap <Leader>% :source %<CR>
nmap <Leader>gs :!git status<CR>
nmap <Leader>ga :!git add .<CR>
nmap <Leader>gc :!git commit -m '
nmap <Leader>gp :!git push<CR>
nmap <Leader>v :!git
nmap <Leader>gb :!git branch
nmap <Leader>gbs :!git branch switch -c
nmap <Leader>gsw :!git switch -<CR>

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gr <Plug>(coc-references)

inoremap jj <ESC>

autocmd BufEnter *.{js,jsx,ts,tsx} :syntax sync fromstart
autocmd BufLeave *.{js,jsx,ts,tsx} :syntax sync clear
autocmd FileType scss setl iskeyword+=@-@
augroup ReactFiletypes
  autocmd!
  autocmd BufRead,BufNewFile *.jsx set filetype=javascriptreact
  autocmd BufRead,BufNewFile *.tsx set filetype=typescriptreact
  autocmd BufRead,BufNewFile *.js set filetype=javascriptreact
augroup END

"Function for Plugins
" Show Documentation if No typescript error exists
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0 && CocHasProvider('hover') == 1)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()
