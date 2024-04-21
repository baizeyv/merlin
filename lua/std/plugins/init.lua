return {
    { "nvim-lua/plenary.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context"
        },
        opts = function()
            return require('std.config.treesitter')
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts.option)
            require('treesitter-context').setup(opts.context)
        end
    }
}
