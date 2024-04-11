local new_cwd = vim.api.nvim_create_user_command
local rc = require("merlin.rc").ui

vim.opt.statusline = "%!v:lua.require('merlin.core.ui.statusline." .. rc.statusline.theme .. "')()"

-- Command to toggle Dashboard
new_cwd("MerlinDash", function ()
    if vim.g.dashboard_displayed then
        -- TODO
        -- require
    else
        require("merlin.core.ui.dashboard").open()
    end
end, {})

-- load dashboard only on empty file
if rc.dashboard.load_on_startup then
    vim.schedule(function ()
        local buf_lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
        local no_buf_content = vim.api.nvim_buf_line_count(0) == 1 and buf_lines[1] == ""
        local bufname = vim.api.nvim_buf_get_name(0)

        if bufname == "" and no_buf_content then
            require("merlin.core.ui.dashboard").open()
        end
    end, 0)
end