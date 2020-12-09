local function optrequire(module, callback)
    local ok, mod = pcall(require, module)
    if ok and callback then
        callback(mod)
    end

    return mod
end

local function pprint(object)
    print(vim.inspect(object))
end

_G.pprint = pprint

return {
    optrequire = optrequire,
    pprint = pprint
}
