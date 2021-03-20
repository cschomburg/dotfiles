return function()
    local configs = require('nvim-treesitter.configs')

    configs.setup {
        -- ensure_installed = { "php "},
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    }
end
