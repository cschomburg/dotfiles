local function optrequire(module, callback)
    local ok, mod = pcall(require, module)
    if ok and callback then
        callback(mod)
    end

    return mod
end

optrequire('colorizer', function (colorizer)
    colorizer.setup()
end)

optrequire('nvim_lsp', function (lsp)
    lsp.tsserver.setup{}
    lsp.intelephense.setup{
        init_options = {}
    }
    lsp.pyls.setup{}
end)

do
    require'nvim-treesitter.configs'.setup {
        -- ensure_installed = { "php "},
        highlight = {
            enable = true,
        },
    }
end

optrequire('snippets', function(snippets)
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
end)
