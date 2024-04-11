vim.g.theme46_cache = vim.fn.stdpath "data" .. "/merlin/theme46/"
print(vim.g.theme46_cache)

-- load options
require("merlin.config.options").load_options()

-- load keymaps (schedule)
require("merlin.config.mappings").load_keymaps()

-- load plugins
require("merlin.core.plugin-loader").load()

-- load ui
require("merlin.core.ui")