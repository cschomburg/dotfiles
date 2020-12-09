return function()
    local lsp = require('lspconfig')

    lsp.tsserver.setup {}
    lsp.intelephense.setup {
        init_options = {}
    }
    lsp.pyls.setup {}
end
