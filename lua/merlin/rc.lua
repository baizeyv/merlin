local M = {}

M.ui = {
    theme = "onedark",
    transparency = true,
    hl_override = {},
    changed_themes = {},
    theme_toggle = { "onedark", "one_light" },
    statusline = {
        -- theme可选值: default, minimal, vscode, color_vscode
        theme = "default",
        -- sep_style 可用的值: default, arrow, block, round
        -- sep_style 还可以是 table: { left = "left_icon", right = "right_icon" }
        sep_style = "default",
        -- order 的可选值
        -- local orders = {
        --     default = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
        --     vscode = { "mode", "file", "diagnostics", "git", "%=", "lsp_msg", "%=", "lsp", "cursor", "cwd" },
        -- }
        order = nil,
        -- modules 的示例: (需要与 orders 中的值对应)
        -- {mode="mode content", file="file content", ......}
        -- 其中的 "mode content" 等类似位置的字符串可以换成一个方法,且返回字符串
        modules = nil
    },
    dashboard = {
        load_on_startup = true,
        header = {
            "           ▄ ▄                   ",
            "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
            "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
            "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
            "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
            "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
            "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
            "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
            "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
        },
        buttons = {
            { "  Find File", "Spc f f", "Telescope find_files" },
            { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
            { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
            { "  Bookmarks", "Spc m a", "Telescope marks" },
            { "  Themes", "Spc t h", "Telescope themes" },
            { "  Mappings", "Spc c h", "NvCheatsheet" },
        }
    }
}

M.theme46 = {
    integrations = {

    }
}

return M