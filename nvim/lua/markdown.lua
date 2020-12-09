local M = {}
local loop = vim.loop
local api = vim.api

function M.convertFile()
    local shortname = vim.fn.expand('%:t:r')
    local fullname = api.nvim.buf_get_name(0)

    handle = vim.loop.spawn('pandoc', {
            args = {
                fullname,
                '--to=html5',
                '-o', string.format('%s.html', shortname),
                '-s',
                '--highlight-style', 'tango',
                '-c', '--css=pandoc.css',
            },
        },
        function()
            print('DOCUMENT CONVERSION COMPLETE')
            handle:close()
        end
    )
end
