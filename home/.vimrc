runtime! autoload/pathogen.vim
silent! call pathogen#runtime_append_all_bundles()

" Section: configuration

    set background=dark


    set guifont=Monaco:h13
    colorscheme solarized
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

    augroup myfiletypes
        " Clear old autocmds in group
        autocmd!
        autocmd FileType ruby,eruby,yaml set autoindent shiftwidth=2 softtabstop=2 tabstop=2 expandtab
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

    set pastetoggle=<C-P> " Ctrl-P toggles paste mode

    " use ctrl-space to exit insert mode
    "inoremap <C-space> <Esc>

    " search next/previous -- center in page
    nmap n nzz
    nmap N Nzz
    nmap * *zz
    nmap # #zz

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

