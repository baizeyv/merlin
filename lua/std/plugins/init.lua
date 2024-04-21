return {
    { "nvim-lua/plenary.nvim" },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects"
        },
        opts = function()
            return require('std.config.treesitter')
        end,
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    }
}
