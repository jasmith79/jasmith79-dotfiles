return {
	"clojure-vim/vim-jack-in",
	-- If you don't already have a Rust toolchain installed instead use
	-- "gpanders/nvim-parinfer",
	{ "eraserhd/parinfer-rust", build = "cargo build --release" },
	{
		"Olical/conjure",
		lazy = true,
		dependencies = { "Olical/AnsiEsc", "PaterJason/cmp-conjure" },
		ft = { "clojure", "fennel", "racket", "scheme", "lua", "lisp", "python", "rust", "sql" },
		init = function()
			vim.g["conjure#eval#result_register"] = "*"
			vim.g["conjure#log#botright"] = true
			vim.g["conjure#mapping#doc_word"] = "gk"
			vim.g["conjure#client#clojure#nrepl#refresh#backend"] = "clj-reload"
			return vim.api.nvim_create_autocmd("FileType", {
				callback = function()
					vim.bo.commentstring = ";; %s"
					return nil
				end,
				desc = "Lisp style line comment",
				group = vim.api.nvim_create_augroup("comment_config", { clear = true }),
				pattern = { "clojure" },
			})
		end,
	},
	{
		"PaterJason/nvim-treesitter-sexp",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		ft = { "clojure", "fennel", "janet", "query" },
		cmd = "TSSexp",
		opts = {},
	},
}
