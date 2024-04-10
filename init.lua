-- load options
require("merlin.config.options").load_options()

-- load keymaps (schedule)
require("merlin.config.mappings").load_keymaps()

-- load plugins
require("merlin.core.plugin-loader").load()

-- load ui
require("merlin.core.ui")