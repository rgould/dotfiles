" BEGIN VUNDLE CONFIG

set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'kana/vim-textobj-user'

Plugin 'nelstrom/vim-textobj-rubyblock'
runtime macros/matchit.vim

Plugin 'posva/vim-vue'
Plugin 'othree/html5.vim'
Plugin 'pedrohdz/vim-yaml-folds'
Plugin 'vimwiki/vimwiki'
Plugin 'preservim/tagbar'
Plugin 'rlue/vim-fold-rspec'
Plugin 'joker1007/vim-ruby-heredoc-syntax'
Plugin 'mileszs/ack.vim'
Plugin 'iloginow/vim-stylus'
Plugin 'tpope/vim-abolish'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" END VUNDLE CONFIG

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

" Stupid work around for error: https://github.com/SirVer/ultisnips/issues/996
if has('python3')
  silent! python3 1
endif

" runtime! autoload/pathogen.vim
" silent! call pathogen#runtime_append_all_bundles()
execute pathogen#infect()

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
    set colorcolumn=80,120
    set guifont=Monaco:h13
    colorscheme solarized
    set t_Co=256
    set nocompatible " We're running Vim, not Vi!
    syntax on
    " Enable filetype-specific indenting and plugins
    filetype plugin indent on
    filetype plugin on
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
    " scroll the view screen when moving within x lines of the end
    set scrolloff=5
    set autoindent shiftwidth=2 softtabstop=2 tabstop=2 expandtab
    set foldmethod=syntax
    set nofoldenable        "dont fold by default
    " set foldnestmax=10      "deepest fold is 10 levels
    " set foldlevel=1
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
    set gdefault
    set history=10000
    " disable until https://github.com/vim/vim/issues/1735 fixed :(
    " set cursorline
    "Reference: http://stackoverflow.com/questions/2732267/vim-loses-undo-history-when-changing-buffers
    "Persistent undo
    set undofile
    set undodir=$HOME/.vim/undo
    set undolevels=1000
    set undoreload=10000
    set switchbuf=useopen " when opening a file, jump to the buffer if it's
                          " already open
    set winwidth=79 " always try to make the current window at least 79 cols
    " Insert only one space when joining lines that contain sentence-terminating
    " punctuation like `.`.
    set nojoinspaces
    " Modelines (comments that set vim options on a per-file basis)
    set modeline
    set modelines=3

    "set tags=./.git/tags
    set tags=./tags,tags;$HOME/tags
    map <leader>r :TlistToggle<CR>

    nnoremap / /\v
    vnoremap / /\v
    hi cursorline cterm=none term=none
    autocmd WinEnter * setlocal cursorline
    autocmd WinLeave * setlocal nocursorline
    " disable until https://github.com/vim/vim/issues/1735 fixed :(
    " autocmd BufEnter * set relativenumber
    nnoremap <tab> %
    vnoremap <tab> %
    nnoremap ; :

    augroup myfiletypes
        " Clear old autocmds in group
        autocmd!
        autocmd FileType ruby,eruby,yaml set autoindent shiftwidth=2 softtabstop=2 tabstop=2 expandtab
        autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
        autocmd Filetype tex setl updatetime=1
        au BufRead,BufNewFile *etc/nginx/* set ft=nginx
        au BufRead,BufNewFile Gemfile set ft=ruby
        au BufRead,BufNewFile Capfile set ft=ruby
        au BufRead,BufNewFile *.god set ft=ruby
        au BufRead,BufNewFile .aliasrc set ft=sh
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

    " open Latex PDFs in Preview
    let g:livepreview_previewer = 'open -a Preview'

"    set statusline=%f
    " set statusline=%t       "tail of the filename
    " set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
    " set statusline+=%{&ff}] "file format
    " set statusline+=%h      "help file flag
    " set statusline+=%m      "modified flag
    " set statusline+=%r      "read only flag
    " set statusline+=%y      "filetype
    " set statusline+=%=      "left/right separator
    " set statusline+=%c,     "cursor column
    " set statusline+=%l/%L   "cursor line/total lines

     "set statusline=%f
     "set statusline+=%=[%{strlen(&fenc)?&fenc:'none'},%{&ff}] " file encoding/format
     "set statusline+=%h%m%r%y " file flags
     "set statusline+=\ \     " separator
     "set statusline+=%l/%L:%c "cursor position
     "set statusline+=\ %P    "percent through file

    set statusline=[%n]\ %<%.99f\ %h%w%m%r%{exists('*CapsLockStatusline')?CapsLockStatusline():''}%y%=%-16(\ %l,%c-%v\ %)%P

    " Syntastic
    " set statusline+=%#warningmsg#
    " set statusline+=%{SyntasticStatuslineFlag()}
    " set statusline+=%*

    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    " let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
    let g:syntastic_ruby_checkers = ['rubocop']

    let g:syntastic_mode_map = {
        \ "mode": "passive",
        \ "active_filetypes": [],
        \ "passive_filetypes": [] }

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
    " open a tag in a vertical split
    map <C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

    function! NumberToggle()
      if(&relativenumber == 1)
        set norelativenumber
      else
        set relativenumber
      endif
    endfunc

    nnoremap <C-x> :call NumberToggle()<cr>
    nmap <F8> :TagbarToggle<CR>


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

    " nnoremap <leader>d :Dispatch<CR>

    " find merge conflict markers
    nmap <silent> <leader>cf <ESC>/\v^[<=>]{7}( .*\|$)<CR>

    set pastetoggle=<C-P> " Ctrl-P toggles paste mode

    " use ctrl-space to exit insert mode
    "inoremap <C-space> <Esc>

    " Insert date-times
    " 2020-08-24:
    nnoremap <leader>D "=strftime('%Y-%m-%d')<CR>P
    inoremap <F2> <C-R>=strftime('%Y-%m-%d')<CR>

    " search next/previous -- center in page
    nmap n nzz
    nmap N Nzz
    nmap * *zz
    nmap # #zz
    nmap <C-D> :NERDTree<cr>
    nmap <C-T> :NERDTreeToggle<cr>

    let g:NERDTreeDirArrows = 1
    let g:NERDTreeDirArrowExpandable = '▸'
    let g:NERDTreeDirArrowCollapsible = '▾'
    let g:NERDTreeGlyphReadOnly = "RO"

    " Rails i18n tools 
    " Extract plain text between HTML tags, yanks to "b:
    " nmap <leader>w 0f>lvf<h"bc<%= t('') %>hhhh
    " Extract plain text from HAML, yanks to "b:
    " nmap <leader>q vg_"bc=t('.')hi
    " Select a double quoted string, yank to b, replace with t('.')
    " nmap <leader>' vi'"byca' t('.')hi
    " Select a single quoted string, yank to b, replace with t('.')
    " nmap <leader>" vi""byca" t('.')hi
    " Select a key, switch to last file (should be .yml file) and output key:
    " string from \"b and "c
    " nmap <leader>a viw"cyoc: "b"
    " End Rails i18n tools

    nnoremap <leader>rt :!foreman run bundle exec rspec %<cr>
    nnoremap <leader>ru :!rspec %<cr>
    nnoremap <leader>c :!rubocop -D %<cr>
    nnoremap <leader>q :!bin/compile<cr>
    nnoremap <leader>ra :Dispatch foreman run bundle exec rake spec<cr>
    nnoremap <leadeR>rs :execute "!rspec %:" . line(".")<cr>

    " delete rspec :focus in current file
    " command Unfocus s /, :focus//

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$

    " Insert newlines without going into insert mode
    nnoremap <leader>j m`o<Esc>``
    nnoremap <leader>k m`O<Esc>``

    " Hide search highlighting
    map <silent> <leader>nh :nohls <CR>

    nnoremap <leader><leader> <c-^>
    nnoremap <leader>a :A<cr>

    " Align selected lines
    vnoremap <leader>ib :!align<cr>

    " Language learning:
    " DE
    " Open the current word in wiktionary:
    "nmap <leader>w :!open https://de.wiktionary.org/wiki/<C-R><C-W><CR><CR>
    "nmap <leader>s :!open "https://dict.tu-chemnitz.de/dings.cgi?lang=en&service=deen&query=<C-R><C-W>"<CR><CR>
    "nmap <leader>x :!open https://dict.leo.org/englisch-deutsch/<C-R><C-W><CR><CR>
    "nmap <leader>d :!open https://www.duden.de/rechtschreibung/<C-R><C-W><CR><CR>
    "nmap <leader>u :!open https://www.dwds.de/wb/<C-R><C-W><CR><CR>
    "nmap <leader>2 :!open https://www.dwds.de/wp/<C-R><C-W><CR><CR>
    "" IS
    "nmap <leader>q :!open "https://deis.dict.cc/?s=<C-R><C-W>"<CR><CR>
    "nmap <leader>a :!echo "http://digicoll.library.wisc.edu/cgi-bin/IcelOnline/IcelOnline.TEId-idx?type=simple&size=First+100&rgn=dentry&q1=<C-R><C-W>&submit=Search" \| sed -e 's/ð/\%F0/g' -e 's/á/\%E1/g' -e 's/é/\%E9/g' -e 's/í/\%ED/g' -e 's/ó/\%F3/g' -e 's/ú/\%FA/g' -e 's/ý/\%FD/g' -e 's/þ/\%FE/g' -e 's/æ/\%E6/g' -e 's/ö/\%F6/g' \| xargs open<CR><CR>
    "nmap <leader>z :!open "https://malid.is/leit/<C-R><C-W>"<CR><CR>

    " UltiSnips
    " Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
    " let g:UltiSnipsExpandTrigger="<tab>"
    " let g:UltiSnipsListSnippets="<c-\|>"
    " let g:UltiSnipsJumpForwardTrigger="<c-j>"
    " let g:UltiSnipsJumpBackwardTrigger="<c-k>"

    " If you want :UltiSnipsEdit to split your window.
    let g:UltiSnipsEditSplit="vertical"

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
nnoremap <leader>f :call SelectaCommand("find . -type d \\( -path ./node_modules -o -path ./storage -o -path ./tmp -o -path ./coverage -o -path ./.git \\) -prune -o -type f", "", ":e")<cr>
nnoremap <leader>p :call SelectaCommand("git ls-files -oc --exclude-standard", "", ":e")<cr>

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
  call SelectaCommand("find . -type d \\( -path ./node_modules -o -path ./storage -o -path ./tmp -o -path ./coverage -o -path ./.git \\) -prune -o -type f", "-s " . @z, ":e")
endfunction
nnoremap <leader>g :call SelectaIdentifier()<cr>

" Auto Reload .vimrc http://stackoverflow.com/questions/2400264/is-it-possible-to-apply-vim-configurations-without-restarting/2403926#2403926
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END
" Auto Reload .vimrc

" BufExplorer
" vim-airline

autocmd BufNewFile,BufRead /Users/rgould/dev/roll20-character-sheets/* set tabstop=4 shiftwidth=4 autoindent noexpandtab

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'lervag/vimtex'
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }
call plug#end()

" anki cloze

function! Cloze()
  execute "normal! ~"
endfunction

vnoremap <leader>c :call Cloze()<cr>
" https://vim.fandom.com/wiki/View_text_file_in_two_columns
noremap <silent> <Leader>ss :<C-u>let @z=&so<CR>:set so=0 noscb<CR>:bo vs<CR>Ljzt:setl scb<CR><C-w>p:setl scb<CR>:let &so=@z<CR>

let wiki_hazkorin = {}
let wiki_hazkorin.name = 'hazkorin'
let wiki_hazkorin.auto_export = 0
let wiki_hazkorin.auto_toc = 1
let wiki_hazkorin.path = '~/ebooks/campaign_notes/hazkorin/src'
let wiki_hazkorin.path_html = '~/ebooks/campaign_notes/hazkorin/html'

let wiki_samedi = {}
let wiki_samedi.name = 'samedi'
let wiki_samedi.auto_toc = 1
let wiki_samedi.path = '~/Documents/vimwiki/src'
let wiki_samedi.path_html = '~/Documents/vimwiki/html'

let wiki_french = {}
let wiki_french.name = 'french'
let wiki_french.auto_toc = 1
let wiki_french.path = '~/Documents/learning_notes/experts_incubator/french'
let wiki_french.path_html = '~/Documents/learning_notes/experts_incubator/french/html'

let wiki_30x500 = {}
let wiki_30x500.name = '30x500'
let wiki_30x500.auto_toc = 1
let wiki_30x500.path = '~/Documents/learning_notes/30x500'
let wiki_30x500.path_html = '~/Documents/learning_notes/30x500/html'

let g:vimwiki_list = [wiki_hazkorin, wiki_french, wiki_samedi, wiki_30x500]
let g:vimwiki_auto_chdir = 1
let g:vimwiki_auto_header = 1

let tlist_vimwiki_settings = 'wiki;h:Headers'
let g:tagbar_type_vimwiki = {
\ 'ctagstype' : 'vimwiki',
\ 'kinds'     : [
\ 'h:header',
\ ],
\ 'sort'    : 0
\ }
