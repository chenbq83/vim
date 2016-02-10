" cd ~/.vim/bundle
" git clone https://github.com/tpope/vim-pathogen
" cp vim-pathogen/autoload/pathogen.vim ~/.vim/autoload

" git clone https://github.com/bling/vim-airline
" git clone https://github.com/easymotion/vim-easymotion
" git clone https://github.com/justinmk/vim-sneak.git
" git clone https://github.com/milkypostman/vim-togglelist.git

execute pathogen#infect()

"""""""""""""""""""
" GENERAL
"""""""""""""""""""
let mapleader = "`"
colorscheme darkblue "solarized
set background=dark
set shortmess=atI
set wrap

set hlsearch
set incsearch
set mouse=a
set t_Co=256
set laststatus=2
set ignorecase
set noswapfile
set scrolloff=10
set backspace=indent,eol,start
set ruler
set nu
set cul
set nobackup
set nowritebackup
set noundofile

let &termencoding=&encoding
set fileencodings=utf-8,gbk,ucs-bom,cp936
set clipboard+=unnamed

set updatetime=1500
"autocmd CursorHold * let @/='\<'.expand("<cword>").'\>'
nnoremap <F3> *
nnoremap <F4> #
nnoremap <F5> :call RebuildCscopeIndex()<CR>

function! RebuildCscopeIndex()
   execute ":silent !echo -n 'Finding cscope files...'"
   let cscopeFile = 'cscope.files'
   execute ":silent !rm -rf ".cscopeFile

   let findArg = " -type f ".
               \ "-name '*.cpp' ".
               \ "-o -name '*.c' ".
               \ "-o -name '*.h' ".
               \ "-o -name '*.js' ".
               \ "-o -name '*.py' ".
               \ "-o -name '*.sh' ".
               \ "-o -name '*.xml' "
   execute ':silent !find .'.findArg.'>> '.cscopeFile
   endfor
   execute ":silent !echo 'DONE'"
   execute ":silent !echo -n 'Building cscope index...'"
   execute ":silent !cscope -bq"
   execute ":silent !echo 'DONE'"
   execute "!echo ''"
   execute "cs reset"
endfunction

syntax on

filetype on
filetype plugin on
filetype plugin indent on

set tabstop=3 smartindent shiftwidth=3 smarttab expandtab
set foldenable foldmarker={,} foldmethod=indent foldlevel=99

nnoremap <space> @=((foldclosed(line('.'))<0)?'zc':'zo')<cr>

nnoremap <leader>h <c-w>h
nnoremap <leader>j <c-w>j
nnoremap <leader>k <c-w>k
nnoremap <leader>l <c-w>l

" Platform
function! MySys()
   if has("win32")
      return "windows"
   else
      return "linux"
   endif
endfunction

"""""""""""""""""
" TAGLIST
"""""""""""""""""
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_Use_Right_Window=1
let g:tagbar_left=1
"nmap <leader>tb :TagbarToggle<cr>
"nmap <leader><leader> :TagbarToggle<cr>:TagbarToggle<cr>:cw 5<cr>
nmap <leader><leader> :ccl<cr>:cw 6<cr>:TagbarToggle<cr>:TagbarToggle<cr>
autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx,*.js call tagbar#autoopen()
map <F2> :QFix<CR>
let g:QFixToggle_Height=6

let g:tagbar_width=25
if MySys() == 'windows'
   set tags=f:\msp\git\msp7\tags
   let g:tagbar_ctags_bin='$VIM/vimfiles/ctags.exe'
else
   set tags=~/git/msp/tags
   let g:tagbar_ctags_bin='/usr/bin/ctags'
endif

""""""""""""""""
" WINMANAGER
""""""""""""""""
let cwd = getcwd()
cd `=cwd`
let g:winManagerWindowLayout="FileExplorer"
let g:winManagerWidth = 35
nnoremap <leader>wm :WMToggle<cr>
let g:AutoOpenWinManager = 1

""""""""""""""""
" CSCOPE
""""""""""""""""
set cscopequickfix=s-,c-,d-,i-,t-,e-,g-,f-
if filereadable("cscope.out")
   cs add cscope.out
endif

" Declaration
nnoremap <leader>s :cs find s <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>ss :cs find s 
" Definition
nnoremap <leader>g :cs find g <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>gg :cs find g 
" Called
nnoremap <leader>c :cs find c <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>cc :cs find c 
" This string
nnoremap <leader>t :cs find t <c-r>=expand("<cword>")<cr><cr>
" egrep
nnoremap <leader>e :cs find e <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>ee :cs find e 
" Filename
nnoremap <leader>f :cs find f <c-r>=expand("<cword>")<cr><cr>
nnoremap <leader>ff :cs find f 
nnoremap <leader>i :cs find i <c-r>=expand("<cfile>")<cr><cr>
nnoremap <leader>d :cs find d <c-r>=expand("<cword>")<cr><cr>

""""""""""""""""
" LOOKUPFILE
""""""""""""""""
"   let g:LookupFile_MinPatLength=3
"   let g:LookupFile_PreserveLastPattern=0
"   let g:LookupFile_PreservePatternHistory=1
"   let g:LookupFile_AlwaysAcceptFirst=1
"   let g:LookupFile_AllowNewFiles=0
"   let g:LookupFile_SortMethod=""
"   if filereadable("/local/home/echbing/git/msp/filenametags")
"      let g:LookupFile_TagExpr='"/local/home/echbing/git/msp/filenametags"'
"   endif
"   nnoremap <leader>ff :LookupFile<cr>

""""""""""""""""
" QUICKFIX
""""""""""""""""
"autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx :copen 5
"nnoremap :cw :cw 5
nnoremap <leader>n :cn<cr>
nnoremap <leader>p :cp<cr>

""""""""""""""""
" MINIBUFEXPLORER
""""""""""""""""
let g:miniBufExplMapCTabSwitchBufs=1
let g:explWinSize=""
let g:miniBufExplModSelTarget=1

""""""""""""""""""""""""""""""
" BufExplorer
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0       " Do not show default help.
let g:bufExplorerShowRelativePath=1  " Show relative paths.
let g:bufExplorerSortBy='mru'        " Sort by most recently used.
let g:bufExplorerSplitRight=0        " Split left.
let g:bufExplorerSplitVertical=1     " Split vertically.
let g:bufExplorerSplitVertSize = 30  " Split width
let g:bufExplorerUseCurrentWindow=0  " Open in new window.
autocmd BufWinEnter \[Buf\ List\] setl nonumber
map <F1> :BufExplorer<CR>

let g:EasyMotion_limit_lines = 10
map <Leader> <Plug>(easymotion-prefix)
map w <Plug>(easymotion-w)
map b <Plug>(easymotion-b)
map f <Plug>(easymotion-lineforward)
"map b <Plug>(easymotion-linebackward)
"map j <Plug>(easymotion-j)
"map k <Plug>(easymotion-k)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
