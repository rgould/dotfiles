" All system-wide defaults are set in $VIMRUNTIME/debian.vim (usually just
" /usr/share/vim/vimcurrent/debian.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vim/vimrc), since debian.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing debian.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

runtime! autoload/pathogen.vim
silent! call pathogen#runtime_append_all_bundles()

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Section: configuration

    set background=dark

    set colorcolumn=80

    set guifont=Monaco:h13
    colorscheme solarized
    set t_Co=256
"    colorscheme ironman

    " These two enable syntax highlighting
    set nocompatible " We're running Vim, not Vi!
    syntax on        " Enable syntax highlighting

    " Enable filetype-specific indenting and plugins
    filetype plugin indent on

    " show the `best match so far' as search strings are typed
    set incsearch

    " Highlight search results once found:
    set hlsearch

    "sm: flashes matching brackets or parentheses
    set showmatch

    "sta: helps with backspacing because of expandtab
    set smarttab

    " Set temporary directory (don't litter local dir with swp/tmp files)
    set directory=/tmp/

    " show whitespace
    set list listchars=tab:\ \ ,trail:·

    " line numbers 
    set number
    setlocal numberwidth=5

    set autoindent shiftwidth=2 softtabstop=2 tabstop=2 expandtab

    " Enable tab complete for commands.
    " first tab shows all matches. next tab starts cycling through the matches
    set wildmenu
    set wildmode=list:longest,full

    " Make backspace work in insert mode
    set backspace=indent,eol,start

    " automatically hide buffers when they are abandoned
    set hidden

    set showcmd             " Show (partial) command in status line.
    set ignorecase          " Do case insensitive matching
    set smartcase           " Do smart case matching
    nnoremap / /\v
    vnoremap / /\v
    set gdefault
    set history=200
    set cursorline
    autocmd BufEnter * set relativenumber
    nnoremap <tab> %
    vnoremap <tab> %
    nnoremap ; :

    augroup myfiletypes
        " Clear old autocmds in group
        autocmd!
        autocmd FileType ruby,eruby,yaml set autoindent shiftwidth=2 softtabstop=2 tabstop=2 expandtab
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        au BufRead,BufNewFile *etc/nginx/* set ft=nginx 
        au BufRead,BufNewFile Gemfile set ft=ruby
        au BufRead,BufNewFile Capfile set ft=ruby
        au BufRead,BufNewFile *.god set ft=ruby
    augroup END

    " Turn on language specific omnifuncs
    autocmd FileType ruby set omnifunc=rubycomplete#Complete
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP
    autocmd FileType c set omnifunc=ccomplete#Complete

    " have some fun with bufexplorer
    let g:bufExplorerDefaultHelp=1       " Do not show default help.
    let g:bufExplorerShowRelativePath=1  " Show relative paths.

" Section: mappings

    let mapleader=","
    " clear out whitespace at the end of the line
    nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
    nmap _= :call Preserve("normal gg=G")<CR>
    map <Leader>n :NERDTreeToggle
    map <C-i> :noh<CR>
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

    nnoremap <leader><leader> <c-^

    " disable cursor keys in normal mode
    map <Left>  :echo "no!"<cr>
    map <Right> :echo "no!"<cr>
    map <Up>    :echo "no!"<cr>
    map <Down>  :echo "no!"<cr>

    " find merge conflict markers
    nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

    set pastetoggle=<C-P> " Ctrl-P toggles paste mode

    " use ctrl-space to exit insert mode
    "inoremap <C-space> <Esc>

    " search next/previous -- center in page
    nmap n nzz
    nmap N Nzz
    nmap * *zz
    nmap # #zz
    nmap <C-D> :NERDTree<cr>
    nmap <C-T> :NERDTreeToggle<cr>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Hide search highlighting
    map <silent> <leader>nh :nohls <CR>

    "cmap ct call Table(2,2,0,0,0)

    " Cucumber tables:
    inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
    function! s:align()
      let p = '^\s*|\s.*\s|\s*$'
      if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
        let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
        let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
        Tabularize/|/l1
        normal! 0
        call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
      endif
    endfunction

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    if has("autocmd")	
      au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
         \| exe "normal g'\"" | endif
    endif


