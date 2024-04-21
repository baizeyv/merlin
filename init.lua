vim.g.mapleader = " "
-- load options
require("std.core.options").load_options()

-- load lazy.nvim
require("std.core.plugin-loader").load()

-- load keymaps (schedule)
require("std.core.keymaps").load_keymaps()
