vim.g.theme46_cache = vim.fn.stdpath "data" .. "/merlin/theme46/"

-- load options
require("merlin.config.options").load_options()

-- load keymaps (schedule)
require("merlin.config.mappings").load_keymaps()

-- load plugins
require("merlin.core.plugin-loader").load()

-- 要在插件加载后把theme46的cache写到data中(如果没有cache的话)

-- load ui
-- require("merlin.core.ui")