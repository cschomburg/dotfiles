return function()
    local snippets = require('snippets')
    snippets.use_suggested_mappings()

    snippets.snippets = {
        _global = {
            date = function() return os.date('%Y-%m-%d') end,
            epoch = function() return tostring(os.time()) end,
            test = "what",
        },

        php = {
            debug = [[\Cake\Error\Debugger::log($1);]],
            log = [[\Cake\Log\Log::info($1);]],
        };
    }
end
