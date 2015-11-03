set nocompatible

if filereadable(glob("~/.vim/vimrc.bundle"))
    source ~/.vim/vimrc.bundle
endif


" Better Feel In the Editor {{{
    set tabstop=2
    set shiftwidth=2
    set expandtab           " Use spaces instead of tab characters
    set nowrap              " Dont't wrap the display lines
    set linebreak
    set splitright          " Open vertical splits on the right
    set splitbelow          " Open the horizontal split below
    set backspace=indent,eol,start
    set incsearch           " Show matching search results as typing
    set ruler               " Show row and column in status bar
    set wildmenu            " Nicer tab completion for :ex commands
    set ignorecase          " Case insensitive search by default
    set smartcase           " Use case sensitive search in a captial letter is used
    set warn                " Show what mode your in (insert, etc.)
    set scrolloff=3         " Number of lines to always show at at the top & bottom
    set autoindent          " Copy the indentation from the previous line
    set colorcolumn=81,120  " Highlight the 81st column (shorthand = :set cc=81)
    set cursorline          " Highlight the line which the cursor is on
    set laststatus=2        " Always show a status bar
    set mouse=a             " Make the mouse work - even in terminals
    set list                " Show `listchars` characters
    set nojoinspaces        " Use 1 space after "." when joining lines instead of 2
    set shiftround          " Indent to the closest shiftwidth
    set exrc                " Allow a .vimrc in the project directory
    set secure              " Make sure those project .vimrc's are safe

    set relativenumber
    set hls
    set listchars=tab:=»,trail:·
    set synmaxcol=128
    set encoding=utf-8
    set number
    set macmeta
" }}}

" Improve vim's scrolling speed {{{
    set ttyfast
    set ttyscroll=10
    set lazyredraw
" }}}

" no bells {{{
    set noerrorbells visualbell t_vb=
    if has('autocmd')
        autocmd GUIEnter * set visualbell t_vb=
    endif
" }}}

" This will set filetype instead of sourcing a file {{{
    au! BufRead,BufNewFile *.rb setfiletype ruby
    au! BufRead,BufNewFile *.haml setfiletype haml
    au! BufRead,BufNewFile *.html setfiletype html
    au! BufRead,BufNewFile *.ino setfiletype cpp
" }}}

" Make vim remember undos, even when the file is closed! {{{
    set undofile                    " Save undo's after file closes
    set undolevels=10000             " How many undos
    set undoreload=10000            " number of lines to save for undo

    " First, do $ mkdir ~/.vim/backup ~/.vim/swp ~/.vim/undo
    set undodir=~/.vim_history/undo//
    set backupdir=~/.vim_history/backup//
    set directory=~/.vim_history/swp//
" }}}

" Automatic Formatting - Remove Trailing Spaces {{{
    autocmd BufWritePre *.rb :%s/\s\+$//e
    autocmd BufWritePre *.haml :%s/\s\+$//e
    autocmd BufWritePre *.html :%s/\s\+$//e
    autocmd BufWritePre *.scss :%s/\s\+$//e
    autocmd BufWritePre *.sh :%s/\s\+$//e
" }}}

" Jump to the next row on long lines {{{
    " map <Down> gj
    " map <Up>   gk
    nnoremap j gj
    nnoremap k gk
" }}}

" Late Sudo {{{
    " If you forgot to sudo, :w!! will write this file with sudo
    " Without this, you could use ':w !sudo tee %'
    cmap w!! w !sudo tee % > /dev/null
" }}}

" :Q and :W are accidental {{{
    cnoreabbrev Q q
    cnoreabbrev W w
" }}}

" Y should act like C and D {{{
    map Y y$
" }}}

" Close buffer without closing window {{{
    map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
" }}}

" Shortcuts for debugging {{{
    autocmd FileType ruby map <leader>d orequire 'pry'; binding.pry; puts ""
    autocmd FileType ruby map <leader>D Orequire 'pry'; binding.pry; puts ""

    autocmd FileType javascript map <leader>d odebugger;
    autocmd FileType javascript map <leader>D Odebugger;

    au BufEnter *.rb syn match error contained "\<binding.pry\>"
    au BufEnter *.rb,*.js syn match error contained "\<debugger\>"
" }}}

" Clipboard {{{
    " Easier way to copy and paste from the global clipboard
    map <leader>p "+p
    map <leader>y "+y

    " Use system clipboard
    " if has('clipboard')
        " set clipboard=unnamed,unnamedplus
    " else
        " On mac and Windows, use * register for copy-paste
        " set clipboard=unnamed
    " endif
" }}}

" Select the entire file {{{
    nmap <leader>a ggVG
" }}}

" Switch windows {{{
    " Cycle across all
    noremap <tab> <c-w><c-w>

    " Between last two
    nnoremap <leader><leader> <C-^>
" }}}

" Common code formatting {{{
    " Format JSON - filter the file through Python to format it
    map =j :%!python -m json.tool<cr>

    " Format Ruby Hash - convert to json and run the above python script
    map =r :%s/=>/:/g<cr>:%!python -m json.tool<cr>

    " Format XML - filter the file through xmllint to indent XML
    map =x :%!xmllint -format -<cr>

    " Remove un-needed whitespace
    map <silent> =w :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" }}}

" Function Keys {{{
    nmap <F6> :set list!<cr>:set list?<cr>
    nmap <F7> :set hls!<cr>:set hls?<cr>
    nmap <F8> :set relativenumber!<cr>:set relativenumber?<cr>
    nmap <F9> :set nu!<cr>:set nu?<cr>
    nmap <F10> :set wrap!<cr>:set wrap?<cr>
    nmap <F11> :set spell!<cr>:set spell?<cr>

    " Toggle diff view (need to toggle on both desired buffers)
    nmap <F12> :set diff! scb!<cr>:set diff?<cr>
" Function Keys }}}

" Break Bad Habits {{{
"    noremap <Up> <NOP>
"    noremap <Down> <NOP>
"    noremap <Left> <NOP>
"    noremap <Right> <NOP>
" }}}

" \m to copy key mapping into a buffer {{{
    map <leader>m :redir => m<bar>silent verbose map<bar>redir END<bar>new<bar>setl buftype=nofile<bar>put=m<bar>setl nomodifiable<CR>
" }}}

" Use Shift-Up, Shift-Down to move lines {{{
    nmap <S-Up> mz:m-2<cr>`z
    nmap <S-Down> mz:m+<cr>`z
    vmap <S-Up> :m'<-2<cr>`>my`<mzgv`yo`z
    vmap <S-Down> :m'>+<cr>`<my`>mzgv`yo`z
" Use Shift-Up, Shift-Down to move lines }}}

" Restore cursor position {{{
    function! RestoreCursor()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
    endfunction

    augroup restoreCursor
    autocmd!
    autocmd BufWinEnter * call RestoreCursor()
    augroup END
" }}}

" vim: sw=4 ts=4 sts=4 et tw=78 foldlevel=0 foldmethod=marker

