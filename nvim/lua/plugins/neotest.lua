return function()
    local neotest = require('neotest');

    neotest.setup({
      adapters = {
        require('neotest-phpunit'),
      },
    })

    local opts = { noremap=true }
    vim.api.nvim_set_keymap('n', '<Leader>t', "<cmd>lua require('neotest').run.run()<CR>", opts)
end
