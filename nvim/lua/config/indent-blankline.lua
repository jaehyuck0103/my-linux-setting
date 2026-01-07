-- color를 Yggdroot/indentLine default랑 똑같이 맞추었다.
-- kanagawa plugin에서 overwrite하므로, kanagawa 뒤에서 실행할 것. (v2일때 얘기.. IndentBlanklineChar 사용했었음)
-- v3에서는 IblIndent 사용
vim.cmd [[highlight IblIndent guifg=grey30 gui=nocombine]]

require("ibl").setup {
    indent = {char = '¦'},
    -- char_blankline = ' ',
    -- show_first_indent_level = false,
    scope = {enabled = false},
}

local hooks = require "ibl.hooks"
hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
    )
