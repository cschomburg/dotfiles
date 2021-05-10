return function()
    require('lualine').setup{
        extensions = { 'fzf' },
        options = {
            theme = 'nord',
        }
    }
end
