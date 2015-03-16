set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'a.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'kien/ctrlp.vim'
Plugin 'tpope/vim-endwise'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'altercation/vim-colors-solarized'
Plugin 'croaky/vim-colors-github'
Plugin 'tpope/vim-fugitive'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'mileszs/ack.vim'
Plugin 'scrooloose/syntastic'
Plugin 'Rails.vim'
Plugin 'vim-scripts/ctags.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'fatih/vim-go'

call vundle#end()            " required
filetype plugin indent on    " required

syntax on
set t_Co=256
set vb t_vb=
"set cursorline
set number
set numberwidth=3
"" setup mouse
set mouse=a
" Indentation
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set shiftround
" Misc
set clipboard=unnamed
set shell=/bin/sh
set laststatus=2
set hlsearch

nnoremap <C-e> :NERDTreeToggle<cr>
nnoremap <Leader>\ :call NERDComment(0,"toggle")<cr>
nnoremap <Leader>b :CtrlPBuffer<cr>
nnoremap <Leader>t :CtrlPTag<cr>
nnoremap <Leader>f :NERDTreeFind<cr>

augroup vimrcEx
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  " Set syntax highlighting for specific file types
  autocmd BufRead,BufNewFile Appraisals set filetype=ruby
  autocmd BufRead,BufNewFile *.md set filetype=markdown

  " Enable spellchecking for Markdown
  autocmd FileType markdown setlocal spell

  " Automatically wrap at 80 characters for Markdown
  autocmd BufRead,BufNewFile *.md setlocal textwidth=80

  " Automatically wrap at 72 characters and spell check git commit messages
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell

  " Allow stylesheets to autocomplete hyphenated words
  autocmd FileType css,scss,sass setlocal iskeyword+=-
augroup END

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
inoremap <S-Tab> <c-n>

" Make it obvious where 80 characters is
set colorcolumn=81

" Numbers
set number
set numberwidth=5

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" Enable folding
set nofoldenable
set foldmethod=syntax
set foldlevel=1
nnoremap <Space> za

if has('gui_running')
  set background=light
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  colorscheme solarized
  set guioptions-=l
  set guioptions-=L
  set guioptions-=r
  set guioptions-=R
  set gfn=Monaco:h12
else
  set background=light
  let g:solarized_termcolors = 16
  let g:solarized_termtrans = 1
  let g:solarized_visibility = "normal"
  let g:solarized_contrast = "high"
  colorscheme solarized
  "colorscheme github
endif

set wildignore=public/**,*.html
let g:ctrlp_max_files = 10000
let g:ctrlp_max_depth = 32
let g:ctrlp_working_path_mode = 'ra'

" The Silver Searcher
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor

    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0

    " Ag command
    command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

"ruby
autocmd FileType ruby,eruby setlocal sw=2 ts=2
au BufRead,BufNewFile *.thor set filetype=ruby
au BufRead,BufNewFile *.lxbuilder set filetype=ruby
au BufRead,BufNewFile *.jbuilder set filetype=ruby
au BufRead,BufNewFile *.jpbuilder set filetype=ruby

" c/c++
set cinoptions=:0,t0,+4,(4
autocmd BufNewFile,BufRead *.[ch] setlocal sw=0 ts=8 noet)

" local settings
if filereadable('.localvim')
  so .localvim
endif
