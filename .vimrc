if v:lang =~ "^ko"
   set fileencodings=euc-kr
   set guifontset=-*-*-medium-r-normal--16-*-*-*-*-*-*-*
elseif v:lang =~ "^ja_JP"
   set fileencodings=euc-jp
   set guifontset=-misc-fixed-medium-r-normal--14-*-*-*-*-*-*-*
elseif v:lang =~ "^zh_TW"
   set fileencodings=big5
   set guifontset=-sony-fixed-medium-r-normal--16-150-75-75-c-80-iso8859-1,-taipei-fixed-medium-r-normal--16-150-75-75-c-160-big5-0
elseif v:lang =~ "^zh_CN"
   set fileencodings=gb2312
   set guifontset=*-r-*
endif
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set smarttab            "
set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showmatch
set incsearch           " show best match so far as search strings are typed
set ignorecase          " make searches case-insensitive,
set smartcase      " unless the search string contains any upper-case characters
set winwidth=80
set nowrap
set laststatus=2
set t_Co=256

"set mouse=a             "enable mouse scrolling and auto visual mode
nnoremap <F6> <C-W>w    " use F6 to cycle through split windows
nnoremap <F5> <C-W>W    " use F5 to cycle back
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost * if line("'\"") | exe "'\"" | endif
  " Remove trailing whitespaces for each line on save
  autocmd BufWritePre * :%s/\s\+$//e
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
 augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For C and C++ files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
  autocmd FileType *      set formatoptions=tcql nocindent comments&
  autocmd FileType c,cpp  set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
 augroup END

 augroup gzip
  " Remove all gzip autocommands
  au!

  " Enable editing of gzipped files
  "	  read:	set binary mode before reading the file
  "		uncompress text in buffer after reading
  "	 write:	compress file after writing
  "	append:	uncompress file, append, compress file
  autocmd BufReadPre,FileReadPre	*.gz set bin
  autocmd BufReadPost,FileReadPost	*.gz let ch_save = &ch|set ch=2
  autocmd BufReadPost,FileReadPost	*.gz '[,']!gunzip
  autocmd BufReadPost,FileReadPost	*.gz set nobin
  autocmd BufReadPost,FileReadPost	*.gz let &ch = ch_save|unlet ch_save
  autocmd BufReadPost,FileReadPost	*.gz execute ":doautocmd BufReadPost " . expand("%:r")

  autocmd BufWritePost,FileWritePost	*.gz !mv <afile> <afile>:r
  autocmd BufWritePost,FileWritePost	*.gz !gzip <afile>:r

  autocmd FileAppendPre			*.gz !gunzip <afile>
  autocmd FileAppendPre			*.gz !mv <afile>:r <afile>
  autocmd FileAppendPost		*.gz !mv <afile> <afile>:r
  autocmd FileAppendPost		*.gz !gzip <afile>:r
 augroup END
endif

" Make backspace work with linux
"set t_kb=^?
"fixdel

set ts=8
set sw=4
set sts=4
set sr
set et
set sta

set statusline  =%{fugitive#statusline()}
"set statusline  =%3*\ B\:%n\ %*     "buffer number
set statusline +=\ %<%F%*            "full path
set statusline +=%m%*                "modified flag

set statusline +=%=%P\               " % lines
set statusline +=%1*%5l%*            "current line
set statusline +=%2*/%L%*            "total lines
set statusline +=%4v\ %*             "virtual column number
""set statusline +=%5*0x%04B\ %*     "character under cursor
set statusline +=\ \ \ %{&ff}%*      "file format
set statusline +=%y%*                "file type

hi User1 term=NONE ctermfg=yellow       ctermbg=darkgrey
hi User2 term=NONE ctermfg=green        ctermbg=darkgrey
hi User3 term=NONE ctermfg=Blue         ctermbg=darkgrey
hi User4 term=NONE ctermfg=cyan         ctermbg=darkgrey
hi User5 term=NONE ctermfg=yellow       ctermbg=darkgrey
hi User6 term=NONE ctermfg=red          ctermbg=darkgrey


set pastetoggle=<F2>    "Toggle auto-ident on/off to paste external text
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

"Show line numbers on left
nnoremap <F3> :set invnumber<CR>
nnoremap <F4> :syn clear longLines<CR>
set numberwidth=6    "Show 6 digits

map <F12> :vsplit

"Save file with CTRL-S, Note this required disabling Ctrl-S/Q in terminal; see .bashrc
nnoremap <C-s> :w!<CR>
imap <C-s> <Esc>:w!<CR>

"Quit with CTRL-Q
nnoremap <C-q> :q<CR>

"Search current word, just press 8, not shift 8 (*)
noremap 8 *

"Map these keys to search Marked items (from mark.vim plugin)
"Search Next
map <C-j> \*
"Search prev
map <C-k> \#
"Mark Item
map <C-m> \m

" Insert a divider
imap <C-l> /******************************************************************************/

" Insert a function header block
imap <C-b> /***************************************************************************************************************************************************************/

" some extra commands for HTML editing
nmap ,mh wbgueyei<<ESC>ea></<ESC>pa><ESC>bba
nmap ,h1 _i<h1><ESC>A</h1><ESC>
nmap ,h2 _i<h2><ESC>A</h2><ESC>
nmap ,h3 _i<h3><ESC>A</h3><ESC>
nmap ,h4 _i<h4><ESC>A</h4><ESC>
nmap ,h5 _i<h5><ESC>A</h5><ESC>
nmap ,h6 _i<h6><ESC>A</h6><ESC>
nmap ,hb wbi<b><ESC>ea</b><ESC>bb
nmap ,he wbi<em><ESC>ea</em><ESC>bb
nmap ,hi wbi<i><ESC>ea</i><ESC>bb
nmap ,hu wbi<u><ESC>ea</i><ESC>bb
nmap ,hs wbi<strong><ESC>ea</strong><ESC>bb
nmap ,ht wbi<tt><ESC>ea</tt><ESC>bb
nmap ,hx wbF<df>f<df>

syn match Todo /FIXME/
syn match Todo /TODO/

hi Directory term=NONE ctermfg=LightCyan
hi Comment term=NONE ctermfg=LightGreen
hi Constant term=NONE ctermfg=Magenta
hi String term=NONE ctermfg=DarkRed
hi Chracter term=NONE ctermfg=Yellow
hi Number term=NONE ctermfg=Yellow
hi Boolean term=NONE ctermfg=Yellow
hi Float term=NONE ctermfg=Yellow
hi Identifier term=NONE ctermfg=Magenta
hi Function term=NONE ctermfg=Magenta
hi Statement term=NONE ctermfg=red
hi Conditional term=NONE ctermfg=Magenta
hi Repeat term=NONE ctermfg=White
hi Label term=NONE ctermfg=White
hi Operator term=NONE ctermfg=LightCyan
hi Keyword term=NONE ctermfg=White
hi Exception term=NONE ctermfg=White
hi PreProc term=NONE ctermfg=Gray
hi Include term=NONE ctermfg=White
hi Define term=NONE ctermfg=LightCyan
hi Macro term=NONE ctermfg=Yellow
hi PreCondit term=NONE ctermfg=LightCyan
hi Type term=NONE ctermfg=LightCyan
hi StorageClass term=NONE ctermfg=Cyan
hi Structure term=NONE ctermfg=LightCyan
hi Typedef term=NONE ctermfg=LightCyan
hi Special term=NONE ctermfg=White
hi SpecialChar term=NONE ctermfg=Cyan
hi Tag term=NONE ctermfg=Cyan
hi Delimiter term=NONE ctermfg=Blue
hi SpecialComment term=NONE ctermfg=Grey
hi Debug term=NONE ctermfg=Red
hi Ignore term=NONE ctermfg=Red
hi Error term=NONE ctermfg=Red
hi Todo term=bold ctermbg=yellow

" Global highlighting overrides
highlight Comment      ctermfg=grey
highlight Constant     ctermfg=white
highlight Search       ctermfg=darkgrey     ctermbg=yellow  term=bold
highlight Special      ctermfg=cyan
highlight StatusLine   ctermfg=darkgrey     ctermbg=green   term=none
highlight StatusLineNC ctermfg=darkgrey     ctermbg=darkred term=none
highlight VertSplit    ctermfg=darkgrey     ctermbg=darkgrey
highlight ErrorMsg     ctermfg=red          ctermbg=black
highlight Error        ctermfg=red          ctermbg=black
highlight WarningMsg   ctermfg=yellow       cterm=standout
highlight SpellBad     ctermfg=red          ctermbg=black       cterm=underline

" C syntax highlighting overrides
highlight cDefine      ctermfg=yellow
highlight cInclude     ctermfg=white
highlight cFormat      ctermfg=cyan
highlight cType        ctermfg=cyan
highlight cPreCondit   ctermfg=blue
highlight cSpecial     ctermfg=red
highlight cNumber      ctermfg=yellow
highlight cConstant    ctermfg=magenta
"highlight cFloat       ctermfg=magenta
highlight cCharacter   ctermfg=blue
highlight cString      ctermfg=darkred
highlight cStatement   ctermfg=red
highlight cComment     ctermfg=green

" Highlight C typedefs and structs (_t, _s)
autocmd BufRead,BufNewFile *.c,*.h syntax match cType /\w\+_t\ze\W/
autocmd BufRead,BufNewFile *.c,*.h syntax match cType /\w\+_s\ze\W/

autocmd BufRead,BufNewFile *.c,*.h syntax match ifType /\w\+IF_t/
autocmd BufRead,BufNewFile *.c,*.h highlight ifType ctermfg=yellow

autocmd BufRead,BufNewFile *.c,*.h syntax match ctxType /\w\+Ctx_t/
autocmd BufRead,BufNewFile *.c,*.h highlight ctxType ctermfg=magenta

autocmd BufRead,BufNewFile *.c syntax match pointer /\*[a-z,A-Z,0-9]*++/
autocmd BufRead,BufNewFile *.c,*.h highlight pointer ctermfg=darkblue

autocmd BufRead,BufNewFile *.m syntax match mComment /[%#].*$/
autocmd BufRead,BufNewFile *.m highlight mComment ctermfg=green

autocmd BufRead,BufNewFile *.m syntax region mBlockComment start=+[#%]{+ end=+[%#]}+
autocmd BufRead,BufNewFile *.m highlight mBlockComment ctermfg=green

