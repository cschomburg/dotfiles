return function()
    local lsp = require('lspconfig')

    -- Language servers
    if vim.env.NVIM_IS_DENO then
        lsp.denols.setup {
            init_options = {
                unstable = true;
            }
        }
    else
        lsp.tsserver.setup {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        }
    end

    lsp.intelephense.setup {
        init_options = {},

        on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
    }

    lsp.pyright.setup {}
    lsp.rust_analyzer.setup {}
    lsp.vuels.setup {}

    -- Mappings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]
end
