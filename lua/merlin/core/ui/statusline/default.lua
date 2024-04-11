local rc = require("merlin.rc").ui.statusline
local sep_style = rc.sep_style
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
-- STL_Normal_Mode_Sep
-- STL_NTerminal_Mode_Sep
-- STL_Visual_Mode_Sep
-- STL_Insert_Mode_Sep
-- STL_Terminal_Mode_Sep
-- STL_Replace_Mode_Sep
-- STL_Select_Mode_Sep
-- STL_Command_Mode_Sep
-- STL_Confirm_Mode_Sep
-- STL_File
-- STL_File_Sep
-- STL_Git_Icons
-- STL_Lsp_Msg
-- STL_Lsp
-- STL_Cwd_Icon
-- STL_Cwd_Text
-- STL_Cwd_Sep
-- STL_Pos_Sep
-- STL_Pos_Icon
-- STL_Lsp_Error
-- STL_Lsp_Warning
-- STL_Lsp_Hints
-- STL_Lsp_Info
-- STL_Empty_Space
--

local default_sep_icons = {
    default = { left = "", right = "" },
    round = { left = "", right = "" },
    block = { left = "█", right = "█" },
    arrow = { left = "", right = "" }
}

local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

-- 左分隔符
local sep_l = separators["left"]
-- 右分隔符
local sep_r = separators["right"]

local M = {}

M.mode = function ()
    -- 没有激活的窗口
    if not utils.is_activewin() then
        return ""
    end

    local modes = utils.modes

    local m = vim.api.nvim_get_mode().mode

    local current_mode = "%#STL_" .. modes[m][2] .. "_Mode#  " .. modes[m][1]
    local mode_sep1 = "%#STL_" .. modes[m][2] .. "_Mode_Sep#" .. sep_r
    return current_mode .. mode_sep1 .. "%#STL_Empty_Space#" .. sep_r
end

M.file = function ()
    local x = utils.file()
    local name = " " .. x[2] .. " "
    return "%#STL_File# " .. x[1] .. name .. "%#STL_File_Sep#" .. sep_r
end

M.git = function ()
    return "%#STL_Git_Icons#" .. utils.git()
end

M.lsp_msg = function ()
    return "%#STL_Lsp_Msg#" .. utils.lsp_msg()
end

M.lsp = function ()
    return "%#STL_Lsp#" .. utils.lsp()
end

M.cwd = function ()
    local icon = "%#STL_Cwd_Icon#" .. "󰉋 "
    local name = vim.loop.cwd()
    name = "%#STL_Cwd_Text#" .. " " .. (name:match "([^/\\]+)[/\\]*$" or name) .. " "
    return (vim.o.columns > 85 and ("%#STL_Cwd_Sep#" .. sep_l .. icon .. name)) or ""
end

M.diagnostics = utils.diagnostics

M.cursor = "%#STL_Pos_Sep#" .. sep_l .. "%#STL_Pos_Icon# %#STL_Pos_Text# %p %% "
M["%="] = "%="

return function ()
    return utils.generate("default", M)
end