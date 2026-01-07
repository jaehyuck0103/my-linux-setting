-- kanagawa config (PaperColor 비슷하게 fg bg color setting)

-- this will affect all the hl-groups where the redefined colors are used
local my_colors = {
	-- use the palette color name...
	sumiInk3 = "#1C1C1C",
	sumiInk4 = "#1C1C1C",
	fujiWhite = "#D0D0D0",
	carpYellow = "#D0D0D0",
}

require("kanagawa").setup({ colors = { palette = my_colors }})
vim.cmd("colorscheme kanagawa")
