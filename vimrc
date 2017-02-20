call plug#begin('~/.vim/plugged')
" Theme
" Get object name for syntax highlighting
" echom synIDattr(synID(line('.'),col('.'),0),'name')
Plug 'neilpeter08/onedark.vim'
Plug 'itchyny/lightline.vim'

" Deoplete
function! DoRemote(arg)
  UpdateRemotePlugins
endfunction
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'thinca/vim-ref'
Plug 'awetzel/elixir.nvim', { 'do': 'yes \| ./install.sh' }
Plug 'carlitux/deoplete-ternjs'
Plug 'Shougo/neco-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-qf'

" Tests
Plug 'janko-m/vim-test'
Plug 'kassio/neoterm'

Plug 'neomake/neomake'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'mhinz/vim-startify'
Plug 'mbbill/undotree'
Plug 'qpkorr/vim-bufkill'
Plug 'ap/vim-buftabline'
Plug 'tpope/vim-endwise'
Plug 'mhinz/vim-signify'
Plug 'mhinz/vim-grepper', { 'branch': 'immediate-output' }
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-rails'
Plug 'vim-ruby/vim-ruby'
Plug 'slim-template/vim-slim'
Plug 'terryma/vim-smooth-scroll'
Plug 'tpope/vim-surround'
Plug 'kana/vim-textobj-user'
Plug 'ntpeters/vim-better-whitespace'
Plug 'ap/vim-css-color'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'easymotion/vim-easymotion'
call plug#end()

" Set python path
let g:python_host_prog  = '/usr/local/bin/python2'
let g:python3_host_prog = '/usr/local/bin/python3'


let mapleader = ","
map <Space> ,

syntax on
filetype plugin on
filetype plugin indent on
" Edit and source vimrc
map <leader>vr :vsp $MYVIMRC<CR>
map <leader>so :source $MYVIMRC<CR>


" Basic Configs
set hidden
set number            " Show line number
set relativenumber    " Show relative number
set ruler
set cursorline
set cursorcolumn
set autoread
au FocusGained,BufEnter * :silent! !
set timeoutlen=500    " Dont wait too long for the next key press (useful for ambigous leader commands)

""
"" Undo history
""

if has("persistent_undo")
  set undodir=~/.undodir/
  set undofile
endif

""
"" Whitespace
""

set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs
set list                          " Show invisible characters
set backspace=indent,eol,start    " backspace through everything in insert mode

" List chars
set listchars=""                  " Reset the listchars
set listchars=tab:\ \             " a tab should display as "  ", trailing whitespace as "."
set listchars+=trail:.            " show trailing spaces as dots
set listchars+=extends:>          " The character to show in the last column when wrap is
" off and the line continues beyond the right of the screen
set listchars+=precedes:<         " The character to show in the last column when wrap is
" off and the line continues beyond the left of the screen



""
"" Searching
""

set hlsearch    " highlight matches
set incsearch   " incremental searching
set ignorecase  " searches are case insensitive...
set smartcase   " ... unless they contain at least one capital letter


""
"" Wild settings
""

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore librarian-chef, vagrant, test-kitchen and Berkshelf cache
set wildignore+=*/tmp/librarian/*,*/.vagrant/*,*/.kitchen/*,*/vendor/cookbooks/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

""
"" Backup and swp files
""

set backupdir=~/.tmp " Where to put backup files
set directory=~/.tmp " Where to put swap files

""
"" User defined commands
""

" Redo
map <C-y> :redo<CR>

" Sane terminal binding
tnoremap <Esc> <C-\><C-n>

" Go to previous buffer
map <Space><Space> <C-^>

" Formats entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" Split management
set splitbelow 								"Make splits default to below...
set splitright								"And to the right. This feels more natural.

" Easier split navigations
noremap <C-J> <C-W><C-J>
noremap <C-K> <C-W><C-K>
noremap <C-L> <C-W><C-L>
noremap <C-H> <C-W><C-H>

" Maps save to Ctrl S
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Copy file path easily for unit testing
set clipboard=unnamedplus
map <leader>cfp :!echo "%:p" \| pbcopy<CR><CR>

" Zoom / Restore window.
function! s:ZoomToggle() abort
  resize
  vertical resize
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <C-w>o :ZoomToggle<CR>

" Remove highlight
map <leader>nh :nohlsearch<CR>

" puts the caller
nnoremap <leader>wtf oputs "#" * 90<c-m>puts caller<c-m>puts "#" * 90<esc>

""
"" Theme
""

if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

set background=dark           " Enable dark background
colorscheme onedark           " Set the colorscheme
" underline searched results instead of highlighting
"highlight Search guibg=NONE guifg=NONE gui=underline
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'component_function': {
      \   'filename': 'LightLineFilename'
      \ },
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightLineFilename()
  return expand('%')
endfunction

" status bar
set statusline=%<[%n]\ %F\ %m%r%y\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}\ %=%-14.(%l,%c%V%)\ %P

""
"" Plugins
""


" Grepper
map <leader>a :GrepperRg<Space>

" Quickfix Window
nmap <leader>qf <Plug>QfCtoggle
let g:qf_mapping_ack_style = 1
autocmd! FileType qf noremap q :cclose<CR>

" Nerdtree
map <leader>e :NERDTreeFind<CR>
map <leader>t :NERDTreeToggle<CR>
" Close vim when nerdtree is the only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Neomake
autocmd! BufWritePost * Neomake
let g:neomake_javascript_enabled_makers = ['eslint']

" Close buffer
map <leader>q :BD<CR>

" Fugitive mapping
nmap <leader>gb :Gblame<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gd :Gdiff<CR>
nmap <leader>gg :Ggrep
nmap <leader>gl :Glog<CR>
nmap <leader>gs :Gstatus<CR>
nmap <leader>gw :Gbrowse<CR>

function! PullCurrentBranch()
  let branch = fugitive#statusline()
  let branch = substitute(branch, '\c\v\[?,GIT\(([a-z0-9\-_\./:]+)\)\]?', $BRANCH.' \1', 'g')
  exe ":Git pull origin" . branch
endfunction

function! PushCurrentBranch()
  let branch = fugitive#statusline()
  let branch = substitute(branch, '\c\v\[?,GIT\(([a-z0-9\-_\./:]+)\)\]?', $BRANCH.' \1', 'g')
  exe ":Git push origin" . branch
endfunction

nmap <leader>gp :call PullCurrentBranch()<CR>
nmap <leader>gP :call PushCurrentBranch()<CR>

" startify
let g:startify_session_dir = '~/.vim/sessions'
let g:startify_session_persistence = 1
let g:startify_relative_path = 1
let g:startify_list_order = [
      \ ['   Sessions:'],
      \ 'sessions',
      \ ['   Recent files:'],
      \ 'files',
      \ ['   Recent files in current directory:'],
      \ 'dir',
      \ ]

" FZF
map <C-P> :Files<CR>
map <leader>b :Buffers<CR>
nnoremap <C-r> :BTags<CR>
autocmd! FileType fzf tnoremap <buffer> <Esc> <c-c>
let g:fzf_buffers_jump = 1  " [Buffers] Jump to the existing window if possible

" Vim Test
map <silent> <leader>ft :TestFile<CR>

if has('nvim')
  " run tests with :T
  let test#strategy = "neoterm"

  let g:neoterm_position = "vertical"

  " pretty much essential: by default in terminal mode, you have to press ctrl-\-n to get into normal mode
  " ain't nobody got time for that
  tnoremap <Esc> <C-\><C-n>
endif

" Deoplete
let g:deoplete#enable_at_startup = 1

" Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Smooth Scroll
nnoremap <silent> <c-u> :call smooth_scroll#up(&scroll*2, 30, 4)<CR>
nnoremap <silent> <c-d> :call smooth_scroll#down(&scroll*2, 30, 4)<CR>
nnoremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 30, 4)<CR>
nnoremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 30, 4)<CR>

" Better whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave " strip whitespace on save
