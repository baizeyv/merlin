return {
    { -- development icons plugin
        "nvim-tree/nvim-web-devicons",
        opts = function()
            return require("std.config.devicons")
        end,
        config = function(_, opts)
            require "nvim-web-devicons".setup(opts)
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function()
            return require("std.config.lualine")
        end,
        config = function(_, opts)
            require("lualine").setup(opts)
        end
    },
    {
        "b0o/incline.nvim",
        event = "VeryLazy",
        opts = function()
            return require("std.config.incline")
        end,
        config = function(_, opts)
            require("incline").setup(opts)
        end
    },
    {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.laststatus = 3
            vim.opt.splitkeep = "screen"
        end,
        opts = function()
            return require("std.config.edgy")
        end,
        config = function(_, opts)
            require("edgy").setup(opts)
        end
    },
    {
        "SmiteshP/nvim-navic",
        event = "VeryLazy",
        opts = function()
            return require("std.config.nvim-navic")
        end,
        config = function(_, opts)
            require("nvim-navic").setup(opts)
        end
    },
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = function()
            return require("std.config.bufferline")
        end,
        config = function(_, opts)
            require("bufferline").setup(opts)
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "VeryLazy",
        dependencies = {
            "HiPhish/rainbow-delimiters.nvim"
        },
        opts = function()
            return require("std.config.ibl")
        end,
        config = function(_, opts)
            require("ibl").setup(opts[1])
            local hooks = opts.hooks
            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = function()
            return require('std.config.gitsigns')
        end,
        config = function(_, opts)
            require("gitsigns").setup(opts)
        end
    }
}
