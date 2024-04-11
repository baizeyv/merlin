local rc = require("merlin.rc").ui.statusline
local sep_style = rc.sep_style
local utils = require("merlin.core.ui.statusline.utils")

--
-- 当前文件中存在的 highlight group
-- STL_Sep_Right
-- STL_Empty_Space
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
-- STL_Normal_Mode_Text
-- STL_NTerminal_Mode_Text
-- STL_Visual_Mode_Text
-- STL_Insert_Mode_Text
-- STL_Terminal_Mode_Text
-- STL_Replace_Mode_Text
-- STL_Select_Mode_Text
-- STL_Command_Mode_Text
-- STL_Confirm_Mode_Text
-- STL_File_Sep
-- STL_File_Bg
-- STL_File_Txt
-- STL_Git_Icons
-- STL_Cwd_Sep
-- STL_Cwd_Bg
-- STL_Cwd_Txt
-- STL_Lsp
-- STL_Lsp_Msg
-- STL_Pos_Sep
-- STL_Pos_Bg
-- STL_Pos_Txt
-- STL_Lsp_Error
-- STL_Lsp_Warning
-- STL_Lsp_Hints
-- STL_Lsp_Info
--

sep_style = (sep_style ~= "round" and sep_style ~= "block") and "block" or sep_style

local default_sep_icons = {
    round = { left = "", right = "" },
    block = { left = "█", right = "█" }
}

local separators = (type(sep_style) == "string" and sep_style) or default_sep_icons[sep_style]

local sep_l = separators["left"]
local sep_r = "%#STL_Sep_Right#" .. separators["right"] .. " %#STL_Empty_Space"

local function gen_block(icon, txt, sep_l_hlgroup, icon_hlgroup, txt_hlgroup)
    return sep_l_hlgroup .. sep_l .. icon_hlgroup .. icon .. " " .. txt_hlgroup .. " " .. txt .. sep_r
end

local is_activewin = utils.is_activewin

local M = {}

M.mode = function ()
    if not is_activewin() then
        return ""
    end

    local modes = utils.modes
    local m = vim.api.nvim_get_mode().mode

    return gen_block(
        "",
        modes[m][1],
        "%#STL_" .. modes[m][2] .. "_Mode_Sep#",
        "%#STL_" .. modes[m][2] .. "_Mode#",
        "%#STL_" .. modes[m][2] .. "_Mode_Text#"
    )
end

M.file = function ()
    local x = utils.file()
    return gen_block(x[1], x[2], "%#STL_File_Sep#", "%#STL_File_Bg#", "%#STL_File_Txt#")
end

M.git = function ()
    return "%#STL_Git_Icons#" .. utils.git()
end

M.lsp_msg = function ()
    return "%#STL_Lsp_Msg" .. utils.lsp_msg()
end

M.diagnostics = utils.diagnostics

M.lsp = function ()
    return "%#STL_Lsp#" .. utils.lsp()
end

M.cwd = function ()
    local name = vim.loop.cwd()
    name = name:match "([^/\\]+)[/\\]*$" or name
    return gen_block("", name, "%#STL_Cwd_Sep#", "%#STL_Cwd_Bg#", "%#STL_Cwd_Txt#")
end

M.cursor = function ()
    return gen_block("", "%l/%c", "%#STL_Pos_Sep#", "%#STL_Pos_Bg#", "%#STL_Pos_Txt#")
end

M["%="] = "%="

return function ()
    utils.generate("default", M)
end