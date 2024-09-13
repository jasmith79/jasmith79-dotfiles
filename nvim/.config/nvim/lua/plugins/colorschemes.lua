return {
	"cocopon/iceberg.vim",
	"EdenEast/nightfox.nvim",
	{
		"catppuccin/nvim",
		as = "catppuccin",
		init = function()
			vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
		end,
	},
	{ "embark-theme/vim", as = "embark" },
	{
		"rose-pine/neovim",
		as = "rose-pine",
		config = function()
			require("rose-pine").setup({
				--- @usage 'main' | 'moon'
				dark_variant = "main",
				bold_vert_split = false,
				dim_nc_background = false,
				disable_background = false,
				disable_float_background = false,
				disable_italics = false,

				--- @usage string hex value or named color from rosepinetheme.com/palette
				groups = {
					background = "base",
					panel = "surface",
					border = "highlight_med",
					comment = "muted",
					link = "iris",
					punctuation = "subtle",

					error = "love",
					hint = "iris",
					info = "foam",
					warn = "gold",

					headings = {
						h1 = "iris",
						h2 = "foam",
						h3 = "rose",
						h4 = "gold",
						h5 = "pine",
						h6 = "foam",
					},
					-- or set all headings at once
					-- headings = 'subtle'
				},

				-- Change specific vim highlight groups
				highlight_groups = {
					ColorColumn = { bg = "rose" },
				},
			})
		end,
	},
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		init = function()
			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme("tokyonight-night")

			-- You can configure highlights by doing something like:
			vim.cmd.hi("Comment gui=none")
		end,
	},
}
