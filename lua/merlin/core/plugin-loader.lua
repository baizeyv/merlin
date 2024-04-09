local M = {}

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

    require("lazy").setup({
        { import = "merlin.plugins" }
    }, lazy_config)
end

return M