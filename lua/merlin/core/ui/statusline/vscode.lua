local utils = require("merlin.core.ui.statusline.utils")

--
-- 当前文件中存在的 highlight group
-- STL_Mode
-- STL_Text
-- STL_Lsp_Error
-- STL_Lsp_Warning
-- STL_Lsp_Hints
-- STL_Lsp_Info
--

local M = {}

M.mode = function ()
    if not utils.is_activewin() then
        return ""
    end

    local modes = utils.modes
    local m = vim.api.nvim_get_mode().mode

    return "%#STL_Mode#  " .. modes[m][1] .. " "
end

M.file = function ()
    local x = utils.file()
    local name = " " .. x[2] .. " "
    return "%#STL_Text#" .. x[1] .. name
end

M.git = utils.git
M.lsp_msg = utils.lsp_msg
M.diagnostics = utils.diagnostics
M.lsp = utils.lsp
M.cursor = "%#STL_Text# Ln %l, Col %c "
M["%="] = "%="

M.cwd = function ()
    local name = vim.loop.cwd()
    name = "%#STL_Mode# 󰉖 " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
    return (vim.o.columns > 85 and name) or ""
end

return function ()
    return utils.generate("vscode", M)
end