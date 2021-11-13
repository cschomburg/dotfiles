return function()
    local null = require('null-ls');

    null.config({
        sources = {
            null.builtins.formatting.phpcsfixer.with({
                command = "./vendor/bin/php-cs-fixer",
            }),
            null.builtins.diagnostics.phpstan,
        },
    });

    local lsp = require('lspconfig')
    lsp['null-ls'].setup {}
end
