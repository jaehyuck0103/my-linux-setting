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
	git = {
		ignore = false, -- Not ignore files on .gitignore
	},
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

local function open_nvim_tree(data)
	-- buffer is a directory
	local directory = vim.fn.isdirectory(data.file) == 1

	if not directory then
		return
	end

	-- change to the directory
	vim.cmd.cd(data.file)

	-- open the tree
	require("nvim-tree.api").tree.open()
end

vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
