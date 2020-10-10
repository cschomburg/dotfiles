require('colorizer').setup()

do
    local lsp = require('nvim_lsp')
    lsp.tsserver.setup{}
    lsp.intelephense.setup{
        init_options = {}
    }
    lsp.pyls.setup{}
end

do
    -- require'nvim-treesitter.configs'.setup {
    --     -- ensure_installed = { "php "},
    --     highlight = {
    --         enable = true,
    --     },
    -- }
end

do
    local snippets = require'snippets'
    snippets.use_suggested_mappings()

    snippets.snippets = {
        _global = {
            date = function() return os.date('%Y-%m-%d') end,
            epoch = function() return tostring(os.time()) end,
            test = "what",
        },

        php = {
            debug = [[\Cake\Error\Debugger::log($1);]],
            log = [[\Cake\Log\Log::info($1);]],
        };
    }
end
