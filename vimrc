execute pathogen#infect()

Helptags " Allow calling :help for plugins installed using pathogen

let mapleader = ","
syntax on
filetype plugin on
filetype plugin indent on
" Edit and source vimrc
map <leader>vr :vsp $MYVIMRC<CR>
map <leader>so :source $MYVIMRC<CR>

" Formats entire file
nnoremap <leader>fef :normal! gg=G``<CR>

" Basic Configs
set number            " Show line number
set relativenumber    " Show relative number
set ruler


""
"" Undo history
""

set undofile
set undodir=~/.vim/undodir


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

" Gui Running
if has("gui_running")
  if has("gui_macvim")
    set fu
  else
    map <silent> <F11>
          \    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>

    " Hide gvim bars
    set guioptions-=m  "menu bar
    set guioptions-=T  "toolbar
    set guioptions-=r  "scrollbar
    set guioptions-=L  "scrollbar
  endif
endif

" Easier split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Maps save to Ctrl S
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Copy file path easily for unit testing
set clipboard=unnamed
map <leader>cfp :!echo "%:p" \| pbcopy<CR><CR>

" Zoom pane (<C-w>= to revert)
map <C-w>o <C-w>\| <bar> <C-w>_

" Remove highlight
map <leader>h :nohlsearch<CR>

""
"" Theme
""

set background=dark
let g:hybrid_custom_term_colors = 1
" let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
colorscheme hybrid
let g:airline_theme = "hybrid"

""
"" Plugins
""

" Ctrlp
if has('nvim')
  noremap <C-r> :BTags<CR>
  noremap <C-p> :Files<CR>
else
  map <C-r> :CtrlPBufTag<CR>
  set tags=./tags
endif

" Ack
nnoremap <leader>a :Ack!<Space>
if executable('rg')
  let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
  " Use ripgrep for ctrlp
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s -u --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
  let g:ctrlp_max_files = 0

  " Use rg over grep
  set grepprg=rg\ --vimgrep

  " Use rg over ack
  let g:ackprg="rg --vimgrep --no-heading"
endif

" Nerdtree
map <leader>e :NERDTreeFind<CR>
map <leader>t :NERDTreeToggle<CR>


" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:statline_syntastic = 0

" Close buffer
map <leader>q :BD<CR>

" Git
map <leader>gbl :Gblame<CR>

" Buftabline
set hidden
nnoremap <C-Tab> :bnext<CR>
nnoremap <C-S-Tab> :bprev<CR>

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
set rtp+=~/.fzf
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)

