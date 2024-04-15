local M = {
    "nvim-lua/plenary.nvim",
    {
        "Bekaboo/deadcolumn.nvim",
        opts = {
            -- scope(string|function)：显示彩色列的范围，有几个可能的值：
                -- 'line'：根据当前行的长度显示彩色列。
                -- 'buffer'：将根据当前缓冲区中最长行的长度显示彩色列（当前行周围最多 1000 行）。
                -- 'visible'：将根据可见区域中最长线的长度显示彩色柱。
                -- 'cursor'：将根据当前光标位置显示彩色列。
                -- function() -> number：回调函数，返回一个数字作为行的长度。
            -- modes（表 | 函数）：在哪种模式下显示彩色列。
                -- 如果modes是一个表，它应该包含模式名称列表
                -- 如果modes是一个函数，它应该接受一个字符串作为模式名称，并返回一个布尔值，指示是否在该模式下显示彩色列。
            -- blending（表）：混合选项。
                -- threshold（数字）：显示彩色列的阈值。
                    -- 如果threshold是 0 到 1 之间的数字，则将其视为相对阈值，当当前行长度超过 的threshold倍时，将显示彩色列colorcolumn。
                    -- 如果threshold是大于 1 的数字，则将其视为固定阈值，当当前行长度超过threshold字符时将显示彩色列。
                -- colorcode（字符串）：用作混合背景颜色的颜色代码。
                -- hlgroup（表）：用作混合背景颜色的高亮组。如果未找到突出显示组，colorcode将使用。
            -- warning（表）：警告颜色选项。
                -- alpha（数字）：警告颜色的 Alpha 值，与背景颜色混合。
                -- offset(number)：警告颜色的偏移量，当行长超过字符数时将显示警告colorcolumn颜色 offset。
                -- colorcode（字符串）：警告颜色的颜色代码。
                -- hlgroup（表）：警告颜色的突出显示组。如果未找到突出显示组，colorcode将使用。
            -- extra（表）：额外功能。
                -- follow_tw（无 | 字符串）：
                    -- 如果follow_tw是nil：功能被禁用。
                    -- 如果follow_tw是字符串：设置colorcolumn时将设置为该值，取消设置textwidth时将恢复为原始值。textwidth
                    -- 该选项的建议值为'+1'。
            scope = 'line', ---@type string|fun(): integer
            ---@type string[]|fun(mode: string): boolean
            modes = function(mode)
                return mode:find('^[ictRss\x13]') ~= nil
            end,
            blending = {
                threshold = 0.75,
                colorcode = '#000000',
                hlgroup = { 'Normal', 'bg' },
            },
            warning = {
                alpha = 0.4,
                offset = 0,
                colorcode = '#FF0000',
                hlgroup = { 'Error', 'bg' },
            },
            extra = {
                ---@type string?
                follow_tw = nil,
            },
        }
    },
    {
        "grapp-dev/nui-components.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim"
        }
    }
}

return M