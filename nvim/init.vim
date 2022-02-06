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

Plug 'Jae-Hyuck/hicursorwords'
Plug 'Yggdroot/indentLine'
" Plug 'ervandew/supertab'  " 자동완성을 tab으로 할 수 있도록, 아랫쪽에 추가한 coc 기본설정과 중복되어 제거

" Colorschemes
"Plug 'NLKNguyen/papercolor-theme'
Plug 'rebelot/kanagawa.nvim'
"Plug 'EdenEast/nightfox.nvim'


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug'tpope/vim-unimpaired'   " buffer 스위칭 단축키가 잘 맵핑 되어 있음.

" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}  " 파이썬 전용 syntax highlight

Plug 'rust-lang/rust.vim'

Plug 'cespare/vim-toml'

Plug 'sbdchd/neoformat'

Plug 'neovimhaskell/haskell-vim'

" requires
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'


Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" 보류
" Plug 'tpope/vim-fugitive'
" Plug 'Shougo/deol.nvim'
" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'scrooloose/nerdtree'   " 기본 내장 netrw 사용해보고
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

" PaperColor config
"set background=dark
"set t_Co=256    " nvim에서는 필요없음. vim에서는 기본값이 8임.
"colorscheme PaperColor

" kanagawa config (PaperColor 비슷하게 fg bg color setting)
lua <<EOF
-- this will affect all the hl-groups where the redefined colors are used
local my_colors = {
    -- use the palette color name...
    sumiInk1 = "#1C1C1C",
    fujiWhite = "#D0D0D0"
}

require'kanagawa'.setup({ colors = my_colors })
vim.cmd("colorscheme kanagawa")
EOF


" vim-airline  " buffer list와 대응하는 넘버를 탭처럼 표시해준다.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#tabline#buffer_nr_show = 1

" vim-airline-theme
let g:airline_theme='minimalist'

" save 할 때, :RustFmt 자동 실행
let g:rustfmt_autosave = 1


" neoformat
" run on save
autocmd BufWritePre * execute ':Neoformat'
" each languages
let g:shfmt_opt="-ci"
let g:neoformat_python_black = {
            \ 'exe': 'black',
            \ 'args': ['-q', '-l 99', '-'],
            \ 'stdin': 1,
            \ }
let g:neoformat_python_isort = {
            \ 'exe': 'isort',
            \ 'args': ['-', '--quiet', '--profile black',],
            \ 'stdin': 1,
            \ }

""""""""""""""""""""""""""""""""""""
"""" 아래와 같이 세팅하면 expand('%:t')가 vim 시작할때 한번만 실행되서, 나중에 버퍼 바꾸면 새로운 파일에 맞추어 반영이 안된다.
"""" default setting에서는 function! neoformat#formatters#c#clangformat()을 실행시키는데, 이건 매번 expand('%:t') 다시 실행시킨다.
"""" clang-format의 --style 옵션의 default가 --style=file인 것 같다.
"""" 그래서 아래 세팅 없애주면 원하는대로 동작하는듯...
""""""""""""""""""""""""""""""""""""
"let g:neoformat_cpp_clangformat = {
"            \ 'exe': 'clang-format',
"            \ 'args': ['-assume-filename=' . expand('%:t'), '--style=file'],
"            \ 'stdin': 1,
"            \ }
"""""""""""""""""""""""""""""""""""""""
let g:neoformat_enabled_python = ['black', 'isort']
let g:neoformat_enabled_haskell = ['brittany']
let g:neoformat_enabled_cpp = ['clangformat']
let g:neoformat_run_all_formatters = 1  " python 때문에 이렇게 해놓긴 했는데, 따로 지정안한 lang에서 여러개 formatter가 깔려있는경우엔... (물론 낮은 가능성)



" haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords



" coc-vim
source ~/.config/nvim/plug-config/coc.vim
source ~/.config/nvim/plug-config/coc-extensions.vim
nmap <silent> gs :CocCommand clangd.switchSourceHeader<CR>


" nvim-tree
source ~/.config/nvim/plug-config/nvim-tree.vim
lua require'nvim-tree'.setup()

" tree-sitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  -- One of "all", "maintained" (parsers with maintainers), or a list of languages
  ensure_installed = "maintained",

  -- Install languages synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing
  ignore_install = {},

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- list of language that will be disabled
    disable = {},

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
EOF


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
