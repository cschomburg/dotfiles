return function()
    local null = require('null-ls');

    null.setup({
        sources = {
            null.builtins.formatting.phpcsfixer.with({
                command = "./vendor/bin/php-cs-fixer",
            }),
            null.builtins.diagnostics.phpstan,
        },

        on_attach = function (client)
            if client.resolved_capabilities.document_formatting then
                vim.cmd([[
                    augroup LspFormatting
                    autocmd! * <buffer>
                    autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
                    augroup END
                ]])
            end
        end,
    });
end
