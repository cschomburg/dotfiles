return function()
    require('lualine').setup{
        extensions = { 'fzf' },
        options = {
            theme = 'nord',
        },
        sections = {
            lualine_c = {{'filename', path = 1}},
        },
    }
end
