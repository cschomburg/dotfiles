return function()
    local configs = require('nvim-treesitter.configs')
    local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()

    parser_configs.http = {
        install_info = {
            url = "https://github.com/NTBBloodbath/tree-sitter-http",
            files = { "src/parser.c" },
            branch = "main",
        },
    }

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
