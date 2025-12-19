return function()
    -- Language servers
    if vim.env.NVIM_IS_DENO then
        vim.lsp.enable('denols')
        vim.lsp.config('denols', {
            init_options = {
                unstable = true;
            }
        })
    else
        vim.lsp.enable('ts_ls')
        vim.lsp.config('ts_ls', {
            on_attach = function(client)
                client.server_capabilities.documentFormattingProvider = false
                client.server_capabilities.documentRangeFormattingProvider = false
            end,
        })
    end

    vim.lsp.enable('intelephense')
    vim.lsp.config('intelephense', {
        init_options = {
        },

        settings = {
            intelephense = {
                runtime = '/run/current-system/sw/bin/intelephense',
                maxMemory = 2048,
                format = {
                    enable = false,
                },
            },
        },

        on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
    })

    vim.lsp.enable('pyright')
    vim.lsp.enable('rust_analyzer')
    vim.lsp.enable('terraformls')
    vim.lsp.enable('volar')
    vim.lsp.config('volar', {
        init_options = {
            vue = {
                hybridMode = false,
            },
        },

        on_attach = function(client)
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
        end,
    })

    -- Mappings
    local opts = { noremap=true, silent=true }
    vim.api.nvim_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format({async = false })]]
end
