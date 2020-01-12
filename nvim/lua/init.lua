require('colorizer').setup()

local lsp = require('nvim_lsp')
lsp.tsserver.setup{}
lsp.intelephense.setup{
    init_options = {}
}
