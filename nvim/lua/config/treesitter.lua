local ts = require("nvim-treesitter")

ts.install("stable")
ts.install("unstable")

local augroup = vim.api.nvim_create_augroup("user_treesitter_main", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
	group = augroup,
	callback = function(args)
		local max_filesize = 50 * 1024 -- 50 KB
		local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
		if ok and stats and stats.size > max_filesize then
			return
		end

		pcall(vim.treesitter.start, args.buf)
		vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
})
