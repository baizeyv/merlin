local new_cwd = vim.api.nvim_create_user_command
local rc = require("merlin.rc").ui

vim.opt.statusline = "%!v:lua.require('merlin.core.ui.statusline." .. rc.statusline.theme .. "')()"