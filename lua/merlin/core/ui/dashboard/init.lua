local M = {}

-- 当前文件中存在的 highlight group
-- Dashboard_Ascii
-- Dashboard_Buttons

dofile(vim.g.theme46_cache .. "dashboard")

local rc = require("merlin.rc").ui.dashboard

local headerAscii = rc.header
local emptyLine = string.rep(" ", vim.fn.strwidth(headerAscii[1]))

table.insert(headerAscii, 1, emptyLine)
table.insert(headerAscii, 2, emptyLine)

headerAscii[#headerAscii+1] = emptyLine
headerAscii[#headerAscii+1] = emptyLine

vim.api.nvim_create_autocmd("BufLeave", {
    callback = function ()
        if vim.bo.ft == "dashboard" then
            vim.g.dashboard_displayed = false
        end
    end
})

local map = function (keys, action)
    for _, v in ipairs(keys) do
        vim.keymap.set("n", v, action, { buffer = true })
    end
end

M.open = function ()
    local buttons = rc.buttons
    local dashWidth = #headerAscii[1] + 3

    local max_height = #headerAscii + 4 + (2 * #buttons) -- 4 = extra spaces i.e top/bottom
    local get_win_height = vim.api.nvim_win_get_height

    vim.g.merlin_previous_buf = vim.api.nvim_get_current_buf()

    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_get_current_win()

    -- switch to larger win if current win is small
    if dashWidth + 6 > vim.api.nvim_win_get_width(0) then
        vim.api.nvim_set_current_win(vim.api.nvim_list_wins()[2])
        win = vim.api.nvim_get_current_win()
    end

    vim.api.nvim_win_set_buf(win, buf)

    local header = headerAscii

    local function add_spacing_to_btns(txt1, txt2)
        local btn_len = vim.fn.strwidth(txt1) + vim.fn.strwidth(txt2)
        local spacing = vim.fn.strwidth(header[1]) - btn_len
        return txt1 .. string.rep(" ", spacing - 1) .. txt2 .. " "
    end

    local function add_padding_to_header(str)
        local pad = (vim.api.nvim_win_get_width(win) - vim.fn.strwidth(str)) / 2
        return string.rep(" ", math.floor(pad)) .. str .. " "
    end

    local dashboard = {}

    for _, val in ipairs(header) do
        table.insert(dashboard, val .. " ")
    end

    for _, val in ipairs(buttons) do
        local str = type(val) ~= "table" and val() or nil
        table.insert(dashboard, str or add_spacing_to_btns(val[1], val[2]) .. " ")
        table.insert(dashboard, header[1] .. " ")
    end

    local result = {}

    -- make all lines available
    for i = 1, math.max(get_win_height(win), max_height) do
        result[i] = ""
    end

    local header_start_index = math.abs(math.floor((get_win_height(win) / 2) - (#dashboard / 2))) + 1 -- 1 = To handle zero case
    local abc = math.abs(math.floor((get_win_height(win) / 2) - (#dashboard / 2))) + 1 -- 1 = to handle zero case

    -- set ascii
    for _, val in ipairs(dashboard) do
        result[header_start_index] = add_padding_to_header(val)
        header_start_index = header_start_index + 1
    end

    vim.api.nvim_buf_set_lines(buf, 0, -1, false, result)

    local dash = vim.api.nvim_create_namespace "dashboard"
    local horiz_pad_index = math.floor((vim.api.nvim_win_get_width(win) / 2) - (dashWidth / 2)) - 2

    for i = abc, abc + #header do
        vim.api.nvim_buf_add_highlight(buf, dash, "Dashboard_Ascii", i, horiz_pad_index, -1)
    end

    for i = abc + #header - 2, abc + #dashboard do
        vim.api.nvim_buf_add_highlight(buf, dash, "Dashboard_Buttons", i, horiz_pad_index, -1)
    end

    vim.api.nvim_win_set_cursor(win, { abc + #header, math.floor(vim.o.columns / 2) - 13 })

    local first_btn_line = abc + #header + 2
    local keybind_lineNrs = {}

    for _, _ in ipairs(buttons) do
        table.insert(keybind_lineNrs, first_btn_line - 2)
        first_btn_line = first_btn_line + 2
    end

    -- disable left/right
    map({ "n", "i", "<left>", "<right>" }, "")

    map({ "u", "<up>" }, function ()
        local cur = vim.fn.line "."
        local target_line = cur == keybind_lineNrs[1] and keybind_lineNrs[#keybind_lineNrs] or cur - 2
        vim.api.nvim_win_set_cursor(win, { target_line, math.floor(vim.o.columns / 2) - 13 })
    end)

    map({ "e", "<down>" }, function ()
        local cur = vim.fn.line "."
        local target_line = cur == keybind_lineNrs[#keybind_lineNrs] and keybind_lineNrs[1] or cur + 2
        vim.api.nvim_win_set_cursor(win, { target_line, math.floor(vim.o.columns / 2) - 13 })
    end)

    -- pressing enter on
    map({"<CR>"}, function ()
        for i, val in ipairs(keybind_lineNrs) do
            if val == vim.fn.line "." then
                local action = buttons[i][3]

                if type(action) == "string" then
                    vim.cmd(action)
                elseif type(action) == "function" then
                    action()
                end
            end
        end
    end)

    require("merlin.core.ui.utils").set_cleanbuf_opts("dashboard")
end

return M