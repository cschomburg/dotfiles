return function()
    local null = require('null-ls');

    null.setup({
        sources = {
            -- null.builtins.formatting.deno_fmt,
            null.builtins.formatting.eslint,
            null.builtins.formatting.phpcsfixer.with({
                command = "./vendor/bin/php-cs-fixer",
            }),
            null.builtins.diagnostics.phpstan,
        },
    });
end
