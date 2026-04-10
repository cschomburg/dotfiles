return function()
    require('nvim-treesitter').setup({
        auto_install = true,
    })

    vim.api.nvim_create_autocmd('FileType', {
        callback = function()
            pcall(vim.treesitter.start)
        end,
    })
end
