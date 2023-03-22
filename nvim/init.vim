" ---------------------------
"  vim plug 기본 설정
"  --------------------------
" vim plug 자동 설치
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
call plug#begin('~/.local/share/nvim/plugged')

" Better Syntax Support
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'jaehyuck0103/hicursorwords'
Plug 'Yggdroot/indentLine'
" Plug 'ervandew/supertab'  " 자동완성을 tab으로 할 수 있도록, 아랫쪽에 추가한 coc 기본설정과 중복되어 제거

" Colorschemes
Plug 'rebelot/kanagawa.nvim'
"Plug 'EdenEast/nightfox.nvim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug'tpope/vim-unimpaired'   " buffer 스위칭 단축키가 잘 맵핑 되어 있음.

Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'
Plug 'sbdchd/neoformat'
Plug 'neovimhaskell/haskell-vim'

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'lambdalisue/suda.vim'

Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'

" 보류
" Plug 'tpope/vim-fugitive'
" Plug 'Shougo/deol.nvim'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" L9  " script 모음??
" command-ta " Fast File navigation
" sparkup  " A parser for a condensed HTML format

" Initialize plugin system
call plug#end()

" --------------------------------------------------
"  패키지 세부 설정
" --------------------------------------------------
" supertab
let g:SuperTabDefaultCompletionType = "<c-n>"  " completion menu 위에서 아래로 스크롤하도록.

" vim-polyglot
""" python
let g:python_highlight_all = 1

" kanagawa
luafile ~/.config/nvim/lua-config/kanagawa.lua

" vim-airline
source ~/.config/nvim/plug-config/vim-airline.vim

" save 할 때, :RustFmt 자동 실행
let g:rustfmt_autosave = 1

" neoformat
source ~/.config/nvim/plug-config/neoformat.vim

" haskell-vim
source ~/.config/nvim/plug-config/haskell-vim.vim


" coc-vim
source ~/.config/nvim/plug-config/coc.vim
source ~/.config/nvim/plug-config/coc-extensions.vim
nmap <silent> gs :CocCommand clangd.switchSourceHeader<CR>

" nvim-tree
luafile ~/.config/nvim/lua-config/nvim-tree.lua

" tree-sitter
luafile ~/.config/nvim/lua-config/treesitter.lua

" vim-gist
let g:gist_post_private = 1  " private post as default.
let g:gist_show_privates = 1  " Show private gists with ":Gist -l":

" --------------------------------------------------
"  기타 프로그램 기본 설정
" --------------------------------------------------
" terminal mode escape key setting
tnoremap <Esc> <C-\><C-N>


"set hi=100  " 명령어 기록을 남길 갯수 지정
set vb  " 오류음 대신 비주얼벨 사용
"set lz  " 매크로 실행중에 화면을 다시 그리지 않음
"set lpl  " 프로그램 시작시 플러그인 로드

" 인코딩 설정 " 필요한가?
" 문서를 읽을 때 BOM 을 자동으로 제거하려면, fencs 맨 앞에 ucs-bom 를 추가하세요. "
" set enc=utf-8
" set fenc=utf-8
" set fencs=utf-8,cp949,cp932,euc-jp,shift-jis,big5,ucs-2le,latin1



" --------------------------------------------------
"  편집 기능 설정
" --------------------------------------------------
set number                " 줄 번호를 붙임 
" set backspace=2         " 삽입 모드에서 백스페이스를 계속 허용
" set autoindent             " 자동 들여쓰기
" set cindent             " C 언어 자동 들여쓰기
" set smartindent         " 역시 자동 들여쓰기
set nowrap                 " 자동 줄바꿈 안함 
set nowrapscan             " 찾기에서 파일의 맨 끝에 이르면 계속하여 찾지 않음
" set ignorecase             " 찾기에서 대/소문자를 구별하지 않음
" set incsearch             " 점진적으로 찾기
" set nobackup             " 백업파일을 만들지 않음
" set nojoinspaces         " J 명령어로 줄을 붙일 때 마침표 뒤에 한칸만 띔
" set ruler                 " 상태표시줄에 커서 위치를 보여줌
" set tabstop=2             " 간격
" set shiftwidth=2         " 자동 들여쓰기 간격
set expandtab           " 탭을 스페이스로 바꿔줌
" set keywordprg=ydic        " K를 눌렀을 때 실행할 명령어
" set showcmd             " (부분적인)명령어를 상태라인에 보여줌
" set showmatch             " 매치되는 괄호의 반대쪽을 보여줌
" set autowrite             " :next나  :make 같은 명령를 입력하면 자동으로 저장
" set linespace=3         " 줄간격
set title                 " 타이틀바에 현재 편집중인 파일을 표시
" set tags+=./tags        " add current directory's generated tags file to available tags
" set textwidth=100        " 100 column이 넘으면 자동 개행
" set colorcolumn=100      " 100 column에 표시
" autocmd FileType python set colorcolumn=99  " File Type별 column 설정
" set completeopt-=preview  " completion preview window 안뜨도록

set tabstop=4  " Tab 너비
set shiftwidth=4  " 자동 인덴트할 때 너비


" ---------------
"  키 맵핑
" ---------------
" buffer 스위칭 관련 맵핑
nnoremap gb :bn<CR>
nnoremap gB :bp<CR>
