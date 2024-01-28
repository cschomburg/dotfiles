return function()
    require('lualine').setup{
        extensions = { 'fzf' },
        options = {
            theme = 'auto',
            globalstatus = true,
        },
        sections = {
            lualine_c = {{'filename', path = 1}},
        },
    }
end
