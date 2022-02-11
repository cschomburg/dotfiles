return function()
    local lsp = require('lspconfig')

    -- Language servers
    if vim.env.NVIM_IS_DENO then
        lsp.denols.setup {
            init_options = {
                unstable = true;
                importMap = './import_map.json';
            }
        }
    else
        lsp.tsserver.setup {}
    end

    lsp.intelephense.setup {
        init_options = {},

        on_attach = function(client)
            client.resolved_capabilities.document_formatting = false
            client.resolved_capabilities.document_range_formatting = false
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
end
