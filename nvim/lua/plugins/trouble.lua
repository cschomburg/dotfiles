return function()
    require('trouble').setup({
        icons = false,
    });

    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>", { silent = true, noremap = true })
end
