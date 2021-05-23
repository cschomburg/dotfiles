return function()
    local lsp = require('lspconfig')

    -- Language servers
    lsp.denols.setup {
        init_options = {
            unstable = true;
        }
    }

    lsp.intelephense.setup {
        init_options = {}
    }

    lsp.pyls.setup {}
    lsp.rust_analyzer.setup {}
    -- lsp.tsserver.setup {}

    -- Mappings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
end
