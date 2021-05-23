return function()
    vim.g.ale_disable_lsp = 1
    vim.g.ale_fix_on_save = 1
    vim.g.ale_open_list = 'on_save'
    vim.g.ale_python_pylint_options = '--errors only'
    vim.g.ale_sign_column_always = 1

    vim.g.ale_linters = {
        elixir = { 'mix' },
        go = { 'go build' },
        php = { 'php', 'phpstan' },
    }
    vim.g.ale_fixers = {
        elixir = {'mix_format'},
        json =  {'fixjson', 'jq'},
        javascript = {'eslint'},
        vue = {'eslint'},
        php = {'php_cs_fixer'},
        python = {'black'},
        rust = {'rustfmt'},
    }
end

