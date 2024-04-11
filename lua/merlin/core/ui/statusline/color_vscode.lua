local utils = require("merlin.core.ui.statusline.utils")

--
-- 当前文件中存在的 highlight group
-- STL_Normal_Mode
-- STL_NTerminal_Mode
-- STL_Visual_Mode
-- STL_Insert_Mode
-- STL_Terminal_Mode
-- STL_Replace_Mode
-- STL_Select_Mode
-- STL_Command_Mode
-- STL_Confirm_Mode
-- STL_Text
-- STL_Lsp
-- STL_Cwd
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
    return "%#STL_" .. modes[m][2] .. "_Mode#" .. "  " .. modes[m][1] .. " "
end

M.file = function ()
    local x = utils.file()
    local name = " " .. x[2] .. " "
    return "%#STL_Text#" .. x[1] .. name
end

M.git = utils.git
M.lsp_msg = utils.lsp_msg
M.diagnostics = utils.diagnostics

M.lsp = function ()
    return "%#STL_Lsp#" .. utils.lsp()
end

M.cursor = "%#STL_Text# Ln %l, Col %c "
M["%="] = "%="

M.cwd = function ()
    local name = vim.loop.cwd()
    name = "%#STL_Cwd# 󰉖 " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
    return (vim.o.columns > 85 and name) or ""
end

return function ()
    return utils.generate("vscode", M)
end