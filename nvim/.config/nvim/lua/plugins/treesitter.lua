require'nvim-treesitter.configs'.setup {
  ensure_installed = {
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
	  "fish",
	  "prisma",
	  "php",
	  "java",
	  "kotlin",
	  "vim",
	  "css",
	  "scss",
	  "elixir",
	  "ocaml",
	  "lua",
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
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

