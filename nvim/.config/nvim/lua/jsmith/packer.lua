-- Install packer if not present
--
--
local fn = vim.fn
local packer = require("packer")
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	packer_bootstrap = fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	vim.cmd [[packadd packer.nvim]]
end

return packer.startup(function(use)
	use("github/copilot.vim")
	use("sbdchd/neoformat")
	use("wbthomason/packer.nvim")
	use({
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup {} end
	})
	use("tomtom/tcomment_vim")
	use("nvim-lua/plenary.nvim")
	use("nvim-lua/popup.nvim")
	use("nvim-telescope/telescope.nvim")
	use("neovim/nvim-lspconfig")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/nvim-cmp")
	use("nvim-lua/lsp_extensions.nvim")
	use("L3MON4D3/LuaSnip")
	use("saadparwaiz1/cmp_luasnip")
	use 'tpope/vim-sleuth'
	use(
		"nvim-treesitter/nvim-treesitter",
		{
			run = ":TSUpdate"
		}
	)
	use("nvim-treesitter/playground")
	use("kyazdani42/nvim-web-devicons")
	use({
		"nvim-lualine/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true }
	})
	use({
		"TimUntersberger/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
		}
	})
	use('jose-elias-alvarez/null-ls.nvim')
	use('MunifTanjim/prettier.nvim')
	use { 'tzachar/cmp-tabnine', run = './install.sh', requires = 'hrsh7th/nvim-cmp' }

	-- colorschemes
	use("folke/tokyonight.nvim")
	use("cocopon/iceberg.vim")
	use("EdenEast/nightfox.nvim")
	use({ "catppuccin/nvim", as = "catppuccin" })
	use({ "embark-theme/vim", as = "embark" })
	use({
		"rose-pine/neovim",
		as = "rose-pine",
	})
	use({ "ranjithshegde/ccls.nvim" })

	-- Autoload plugins on fresh install
	if packer_bootstrap then
		packer.sync()
	end
end)
