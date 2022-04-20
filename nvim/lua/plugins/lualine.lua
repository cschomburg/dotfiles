return function()
    require('lualine').setup{
        extensions = { 'fzf' },
        options = {
            theme = 'nord',
            globalstatus = true,
        },
        sections = {
            lualine_c = {{'filename', path = 1}},
        },
    }
end
