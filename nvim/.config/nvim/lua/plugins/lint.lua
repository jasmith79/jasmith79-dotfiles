return {
	{ -- Linting
		"mfussenegger/nvim-lint",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lint = require("lint")
			lint.linters_by_ft = lint.linters_by_ft or {}
			lint.linters_by_ft["markdown"] = { "markdownlint" }
			lint.linters_by_ft["clojure"] = { "clj-kondo" }
			lint.linters_by_ft["javascript"] = { "eslint_d" }
			lint.linters_by_ft["typescript"] = { "eslint_d" }
			lint.linters_by_ft["javascriptreact"] = { "eslint_d" }
			lint.linters_by_ft["typescriptreact"] = { "eslint_d" }
			lint.linters_by_ft["svelte"] = { "eslint_d" }
			lint.linters_by_ft["dockerfile"] = { "hadolint" }

			-- Create autocommand which carries out the actual linting
			-- on the specified events.
			local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
			vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
				group = lint_augroup,
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}
