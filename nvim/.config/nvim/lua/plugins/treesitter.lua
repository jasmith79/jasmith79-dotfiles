return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			-- I don't have a problem.
			-- Oh, you didn't say I had a problem?
			-- Good, 'cause I don't have one.
			"c",
			"toml",
			"svelte",
			"glsl",
			"dockerfile",
			"yaml",
			"jsonc",
			"json",
			"hjson",
			"ninja",
			"cmake",
			"make",
			"go",
			"graphql",
			"ruby",
			"http",
			"prisma",
			"php",
			"java",
			"kotlin",
			"css",
			"scss",
			"elixir",
			"ocaml",
			"cpp",
			"swift",
			"javascript",
			"typescript",
			"html",
			"tsx",
			"bash",
			"markdown",
			"clojure",
			"fennel",
			"haskell",
			"rust",
			"dot",
			"hcl",
			"diff",
			"luadoc",
			"vim",
			"vimdoc",
		},
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			--  If you are experiencing weird indenting issues, add the language to
			--  the list of additional_vim_regex_highlighting and disabled languages for indent.
			additional_vim_regex_highlighting = { "ruby" },
		},
		-- indent = { enable = true, disable = { "ruby" } },
	},
	config = function(_, opts)
		require("nvim-treesitter.install").prefer_git = true
		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup(opts)

		-- There are additional nvim-treesitter modules that you can use to interact
		-- with nvim-treesitter. You should go explore a few and see what interests you:
		--
		--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
		--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
		--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
	end,
}