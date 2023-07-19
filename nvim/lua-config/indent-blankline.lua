-- color를 Yggdroot/indentLine default랑 똑같이 맞추었다.
-- kanagawa plugin에서 overwrite하므로, kanagawa 뒤에서 실행할 것.
vim.cmd [[highlight IndentBlanklineChar guifg=grey30 gui=nocombine]]

require("indent_blankline").setup {
    char = '¦',
    -- char_blankline = ' ',
    show_first_indent_level = false,
}
