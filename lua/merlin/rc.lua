local M = {}

M.ui = {
    statusline = {
        -- theme可选值: default, minimal
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
    }
}

return M