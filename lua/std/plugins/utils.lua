return {
    {
        "rainbowhxch/accelerated-jk.nvim",
        event = { "VeryLazy" },
        opts = function()
            return require("std.config.accelerated")
        end,
        config = function(_, opts)
            require("accelerated-jk").setup(opts)
            vim.api.nvim_set_keymap('', 'e', '<cmd>lua require("accelerated-jk").move_to("gj")<CR>', { silent = true, noremap = true, desc = "Move Down" })
            vim.api.nvim_set_keymap('', 'u', '<cmd>lua require("accelerated-jk").move_to("gk")<CR>', { silent = true, noremap = true, desc = "Move Up" })
        end
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = function()
            return require("std.config.persistence")
        end,
        config = function(_, opts)
            require("persistence").setup(opts)
            -- restore the session for the current directory
            vim.api.nvim_set_keymap("n", "<leader>qs", [[<cmd>lua require("persistence").load()<cr>]], {})

            -- restore the last session
            vim.api.nvim_set_keymap("n", "<leader>ql", [[<cmd>lua require("persistence").load({ last = true })<cr>]], {})

            -- stop Persistence => session won't be saved on exit
            vim.api.nvim_set_keymap("n", "<leader>qd", [[<cmd>lua require("persistence").stop()<cr>]], {})
        end
    },
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = function()
            return require("std.config.autopairs")
        end,
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            opts.rule()
        end
    },
    {
        "nat-418/boole.nvim",
        event = "BufReadPre",
        opts = function()
            return require('std.config.boole')
        end,
        config = function(_, opts)
            require('boole').setup(opts)
        end
    },
    {
        "ethanholz/nvim-lastplace",
        event = "BufReadPre",
        opts = function()
            return require('std.config.lastplace')
        end,
        config = function(_, opts)
            require('nvim-lastplace').setup(opts)
        end
    }
}
