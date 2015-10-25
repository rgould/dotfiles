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
    " :autocmd BufRead,BufNewFile /Users/rgould/okgrow/Workpop-Web/* setlocal ts=4 sw=4

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
    hi cursorline cterm=none term=none
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
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
    " .md defaults to Modula-2. We probably want markdown
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown

    " have some fun with bufexplorer
    let g:bufExplorerDefaultHelp=1       " Do not show default help.
    let g:bufExplorerShowRelativePath=1  " Show relative paths.

" Section: mappings

    let mapleader=","
    " clear out whitespace at the end of the line
    nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>
    nmap _= :call Preserve("normal gg=G")<CR>
    map <Leader>8 :let &background = ( &background == "dark"? "light" : "dark" )<CR>
    map <C-i> :noh<CR>
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

    function! NumberToggle()
      if(&relativenumber == 1)
        set number
      else
        set relativenumber
      endif
    endfunc

    nnoremap <C-x> :call NumberToggle()<cr>


    " when some text is selected, copy it to OSX's clipboard with this
    vmap <C-c> :w !pbcopy<cr>

    nnoremap <leader><leader> <c-^

    " disable cursor keys in normal mode
    map <Left>  :echo "no!"<cr>
    map <Right> :echo "no!"<cr>
    map <Up>    :echo "no!"<cr>
    map <Down>  :echo "no!"<cr>

    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    map <leader>e :edit %%
    map <leader>v :view %%

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

    " Rails i18n tools
    " Extract plain text from HAML, yanks to "b:
    nmap <leader>q vg_"bc=t('.')hi
    " Select a double quoted string, yank to b, replace with t('.')
    nmap <leader>' vi'"byca' t('.')hi
    " Select a double quoted string, yank to b, replace with t('.')
    nmap <leader>" vi""byca" t('.')hi

    " Select a key, switch to last file (should be .yml file) and output key:
    " string from \"b and "c
    nmap <leader>a viw"cyoc: "b"

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Insert newlines without going into insert mode
    nnoremap <leader>j m`o<Esc>``
    nnoremap <leader>k m`O<Esc>``

    " Hide search highlighting
    map <silent> <leader>nh :nohls <CR>

    " Ruby stuff
    " hashrocket
    imap <C-l> <Space>=><Space>

    " Uncomment the following to have Vim jump to the last position when
    " reopening a file
    " if has("autocmd")	
    "   au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    "      \| exe "normal g`\"" | endif
    " endif
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
    set nostartofline " don't jump to start of line when switching buffers

" Escape special characters in a string for exact matching.
" This is useful to copying strings from the file to the search tool
" Based on this - http://peterodding.com/code/vim/profile/autoload/xolox/escape.vim
function! EscapeString (string)
  let string=a:string
  " Escape regex characters
  let string = escape(string, '^$.*\/~[]')
  " Escape the line endings
  let string = substitute(string, '\n', '\\n', 'g')
  return string
endfunction

" Get the current visual block for search and replaces
" This function passed the visual block through a string escape function
" Based on this - http://stackoverflow.com/questions/676600/vim-replace-selected-text/677918#677918
function! GetVisual() range
  " Save the current register and clipboard
  let reg_save = getreg('"')
  let regtype_save = getregtype('"')
  let cb_save = &clipboard
  set clipboard&

  " Put the current visual selection in the " register
  normal! ""gvy
  let selection = getreg('"')

  " Put the saved registers and clipboards back
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save

  "Escape any special characters in the selection
  let escaped_selection = EscapeString(selection)

  return escaped_selection
endfunction

" Start the find and replace command across the entire file
vmap <leader>z <Esc>:%s/<c-r>=GetVisual()<cr>/

" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! SelectaCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | selecta " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction

" Find all files in all non-dot directories starting in the working directory.
" Fuzzy select one of those. Open the selected file with :e.
nnoremap <leader>f :call SelectaCommand("find * -type f", "", ":e")<cr>

function! Get_visual_selection()
  let [lnum1, col1] = getpos("'<")[1:2]
  let [lnum2, col2] = getpos("'>")[1:2]
  let lines = getline(lnum1, lnum2)
  let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
  let lines[0] = lines[0][col1 - 1:]
  return join(lines, "\n")
endfunction

function! SelectaIdentifier()
  " Yank the word under the cursor into the z register
  normal "zyiw
  " Fuzzy match files in the current directory, starting with the word under
  " the cursor
  call SelectaCommand("find * -type f", "-s " . @z, ":e")
endfunction
nnoremap <leader>g :call SelectaIdentifier()<cr>
