return function()
    local rest = require('rest-nvim')

    rest.setup({
        result_split_horizontal = false,
        skip_ssl_verification = false,
    })

    local opts = { noremap=true }
    vim.api.nvim_set_keymap('n', '<Leader>r', "<cmd>lua require('rest-nvim').run()<CR>", opts)
end

-- GET http://localhost:8000
