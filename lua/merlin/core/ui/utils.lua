local M = {}

M.set_cleanbuf_opts = function (ft)
    local opt = vim.opt_local

    opt.buflisted = false
    opt.modifiable = false
    opt.buftype = "nofile"
    opt.number = false
    opt.list = false
    opt.wrap = false
    opt.relativenumber = false
    opt.cursorline = false
    opt.colorcolumn = "0"
    opt.foldcolumn = "0"

    vim.opt_local.filetype = ft
    vim.g[ft .. "_displayed"] = true
end

return M