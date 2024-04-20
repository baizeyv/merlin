local devicons = require("nvim-web-devicons")
local navic = require("nvim-navic")
local helpers = require("incline.helpers")

local M = {
    window = {
        padding = 0,
        margin = { horizontal = 0, vertical = 0 }
    },
    render = function(props)
        local function get_diagnostic_label()
            local icons = { error = '', warn = '', info = '', hint = '' }
            local label = {}

            for severity, icon in pairs(icons) do
                local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
                if n > 0 then
                    table.insert(label, { icon .. n .. ' ', group = "DiagnosticSign" .. severity })
                end
            end
            if #label > 0 then
                table.insert(label, { '┊ ' })
            end
            return label
        end

        local function get_git_diff()
            local icons = { removed = '', changed = '', added = '' }
            local signs = vim.b[props.buf].gitsigns_status_dict
            local labels = {}
            if signs == nil then
                return labels
            end
            for name, icon in pairs(icons) do
                if tonumber(signs[name]) and signs[name] > 0 then
                    table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
                end
            end
            if #labels > 0 then
                table.insert(labels, { '┊ ' })
            end
            return labels
        end

        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
        if filename == '' then
            filename = "[No Name]"
        end

        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        local res = {}
        local file_part = {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or ' ',
            { ' ' .. filename, gui = modified and 'bold,italic' or 'bold' },
            ' ',
            guibg = '#44406e'
        }
        if props.focused then
            for _, item in ipairs(navic.get_data(props.buf) or {}) do
                table.insert(res, {
                    { ' > ', group = "NavicSeparator" },
                    { item.icon, group = "NavicIcons" .. item.type },
                    { item.name, group = "NavicText" }
                })
            end
        end
        table.insert(res, get_diagnostic_label())
        table.insert(res, get_git_diff())
        table.insert(res, file_part)
        table.insert(res, " ")

        return res
    end
}

return M
