local cmp = require('cmp')
local Remap = require('jsmith.keymap')

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<S-Tab>'] = cmp.mapping.select_prev_item(),
        ['<Tab>'] = cmp.mapping.select_next_item(),
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Thanks prime!
local function config(_config)
    return vim.tbl_deep_extend("force", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
        on_attach = function()
            Remap.nnoremap("gd", function() vim.lsp.buf.definition() end)
            Remap.nnoremap("K", function() vim.lsp.buf.hover() end)
            Remap.nnoremap("<leader>vws", function() vim.lsp.buf.workspace_symbol() end)
            Remap.nnoremap("<leader>vd", function() vim.diagnostic.open_float() end)
            Remap.nnoremap("[d", function() vim.diagnostic.goto_next() end)
            Remap.nnoremap("]d", function() vim.diagnostic.goto_prev() end)
            Remap.nnoremap("<leader>vca", function() vim.lsp.buf.code_action() end)
            Remap.nnoremap("<leader>vrr", function() vim.lsp.buf.references() end)
            Remap.nnoremap("<leader>vrn", function() vim.lsp.buf.rename() end)
            Remap.inoremap("<C-h>", function() vim.lsp.buf.signature_help() end)
        end,
    }, _config or {})
end

local lspconfig = require("lspconfig")
lspconfig.tsserver.setup(config())
lspconfig.jedi_language_server.setup(config())
lspconfig.rust_analyzer.setup(config({
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
}))

lspconfig.lua_ls.setup(config({
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
                enable = false,
            },
        },
    },
}))

lspconfig.bashls.setup(config())
lspconfig.marksman.setup(config())
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.cssls.setup(config({
    capabilities = capabilities,
}))

lspconfig.hls.setup(config({
    settings = {
        haskell = {
            hlintOn = true,
            formattingProvider = "fourmolu"
        }
    }
}))

vim.g.neoformat_try_node_exe = 1
