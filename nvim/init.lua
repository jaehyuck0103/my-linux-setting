-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	-- CoC
	{
		"neoclide/coc.nvim",
		branch = "release",
		config = function()
			vim.cmd("runtime plug-config/coc.vim")
			vim.cmd("runtime plug-config/coc-extensions.vim")

			-- CoC 전용 키맵 (Lua 방식)
			vim.keymap.set("n", "gs", ":CocCommand clangd.switchSourceHeader<CR>", { silent = true })
		end,
	},

	-- vim-illuminate
	{
		"RRethy/vim-illuminate",
		opts = {
			-- 어떤 엔진을 쓸지 결정 (LSP/Treesitter 무시하고 싶으면 "regex"만 남기기)
			providers = {
				-- "lsp",
				-- "treesitter",
				"regex",
			},
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function set_kanagawa_illuminate()
				local hi_color = "#7FB4CA" -- 단어 글자색

				-- 1. 일반적인 텍스트 일치 (Regex 기반 등)
				vim.api.nvim_set_hl(0, "IlluminatedWordText", { fg = hi_color, bold = true, underline = true })
				-- 2. LSP가 '읽기'로 판단한 경우
				vim.api.nvim_set_hl(0, "IlluminatedWordRead", { fg = hi_color, bold = true, underline = true })
				-- 3. LSP가 '쓰기/수정'으로 판단한 경우
				vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { fg = hi_color, bold = true, underline = true })
			end

			-- 설정 적용
			set_kanagawa_illuminate()

			-- 테마를 다시 로드하거나 변경해도 유지되도록 함
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = set_kanagawa_illuminate,
			})
		end,
	},

	-- Kanagawa Theme
	{
		"rebelot/kanagawa.nvim",
		config = function()
			require("config.kanagawa")
			vim.cmd("colorscheme kanagawa") -- 테마 적용
		end,
	},

	-- Indent Blankline
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("config.indent-blankline")
		end,
	},

	-- Bufferline
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",

		init = function()
			vim.opt.termguicolors = true

			-- Buffer Switching
			vim.keymap.set("n", "gb", "<cmd>bn<cr>")
			vim.keymap.set("n", "gB", "<cmd>bp<cr>")
		end,

		config = function()
			require("bufferline").setup({})
		end,
	},

	-- Lualine
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },

		opts = {
			sections = {
				lualine_c = {
					{ "filename", path = 1 }, -- 1: relative path
				},
			},
		},
	},

	-- conform (formatter)
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			format_on_save = {
				timeout_ms = 2000,
				lsp_format = "fallback",
			},

			-- 언어별 formatter 지정 (여러 개면 순차 실행)
			formatters_by_ft = {
				python = { "ruff_organize_imports", "black" },
				cpp = { "clang-format" },
				c = { "clang-format" },
				cuda = { "clang-format" },
				cmake = { "cmake_format" },
				sh = { "shfmt" },
				lua = { "stylua" },
			},

			-- formatter 동작/옵션 커스터마이즈
			formatters = {

				shfmt = {
					prepend_args = { "-ci" },
				},

				black = {
					append_args = { "-l", "99" },
				},
			},
		},
	},

	-- nvim-tree
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.nvim-tree")
		end,
	},

	-- Treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("config.treesitter")
		end,
	},

	-- suda
	"lambdalisue/suda.vim",

	-- Gist
	{
		"mattn/vim-gist",
		dependencies = { "mattn/webapi-vim" },
		config = function()
			vim.g.gist_post_private = 1
			vim.g.gist_show_privates = 1
		end,
	},
})

-- --------------------------------------------------
--  4. 편집 기능 설정 (Options)
-- --------------------------------------------------
vim.opt.number = true -- 줄 번호 표시
vim.opt.wrap = false -- 자동 줄바꿈 안함
vim.opt.wrapscan = false -- 검색 시 파일 끝에서 처음으로 돌아가지 않음 (nowrapscan)
vim.opt.expandtab = true -- 탭을 스페이스로 변환
vim.opt.title = true -- 타이틀바에 파일명 표시
vim.opt.tabstop = 4 -- 탭 너비
vim.opt.shiftwidth = 4 -- 인덴트 너비
vim.opt.visualbell = true -- 오류음 대신 비주얼벨 사용 (set vb)
-- set backspace=2         " 삽입 모드에서 백스페이스를 계속 허용
-- set autoindent             " 자동 들여쓰기
-- set cindent             " C 언어 자동 들여쓰기
-- set smartindent         " 역시 자동 들여쓰기
-- set ignorecase             " 찾기에서 대/소문자를 구별하지 않음
-- set incsearch             " 점진적으로 찾기
-- set nobackup             " 백업파일을 만들지 않음
-- set nojoinspaces         " J 명령어로 줄을 붙일 때 마침표 뒤에 한칸만 띔
-- set ruler                 " 상태표시줄에 커서 위치를 보여줌
-- set shiftwidth=2         " 자동 들여쓰기 간격
-- set showcmd             " (부분적인)명령어를 상태라인에 보여줌
-- set showmatch             " 매치되는 괄호의 반대쪽을 보여줌
-- set linespace=3         " 줄간격
-- set textwidth=100        " 100 column이 넘으면 자동 개행
-- set colorcolumn=100      " 100 column에 표시
-- autocmd FileType python set colorcolumn=99  " File Type별 column 설정

-- --------------------------------------------------
--  5. 키 맵핑 (Keymaps)
-- --------------------------------------------------
-- Terminal mode escape
vim.keymap.set("t", "<Esc>", "<C-\\><C-N>", { noremap = true })
