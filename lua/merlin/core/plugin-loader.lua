local M = {}

local key = {
    home = { "H" },
    install = { "T", "t" },
    update = { "A", "a" },
    sync = { "S" },
    clean = { "X", "x" },
    check = { "C", "c" },
    log = { "L", "l" },
    restore = { "R", "r" },
    profile = { "P" },
    debug = { "D" },
    help = { "?" },
    build = { "nil", "gb" }
}

local function load_lazy_keymap()
    local command = require("lazy.view.config").commands
    for key, value in pairs(key) do
        for idx, k in ipairs(value) do
            if idx == 1 and k ~= "nil" then
                command[key].key = k
            elseif idx == 2 then
                command[key].key_plugin = k
            end
        end
    end
end

M.load = function ()
    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazypath) then
        local lazyrepo = "https://github.com/folke/lazy.nvim.git"
        local filter = "--filter=blob:none"
        local branch = "--branch=stable"
        vim.fn.system({
            "git",
            "clone",
            filter,
            lazyrepo,
            branch,
            lazypath
        })
    end
    vim.opt.rtp:prepend(lazypath)

    local lazy_config = require("merlin.config.lazy")

    load_lazy_keymap()
    
    require("lazy").setup({
        { import = "merlin.plugins" }
    }, lazy_config)
end

return M