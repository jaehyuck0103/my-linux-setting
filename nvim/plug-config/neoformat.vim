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
