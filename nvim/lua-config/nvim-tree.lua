vim.cmd("nnoremap <C-n> :NvimTreeToggle<CR>")
vim.cmd("nnoremap <leader>r :NvimTreeRefresh<CR>")
vim.cmd("nnoremap <leader>n :NvimTreeFindFile<CR>")
-- NvimTreeOpen, NvimTreeClose, NvimTreeFocus, NvimTreeFindFileToggle, and NvimTreeResize are also available if you need them

vim.cmd("set termguicolors") -- this variable must be enabled for colors to be applied properly

-- a list of groups can be found at `:help nvim_tree_highlight`
-- highlight NvimTreeFolderIcon guibg=blue

require("nvim-tree").setup({
	create_in_closed_folder = false,
	respect_buf_cwd = true,
	renderer = {
		add_trailing = true,
		group_empty = true,
		highlight_git = true,
		highlight_opened_files = "all",
		indent_markers = {
			enable = true,
		},
		icons = {
			show = {
				file = false,
				folder = false,
				folder_arrow = false,
				git = false,
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = true,
		},
	},
})
