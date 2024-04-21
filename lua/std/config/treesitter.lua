local M = {}

M.option = {
    -- A list of parser names, or "all" (the five listed parsers should always be installed)
    ensure_installed = { "c", "lua", "luadoc", "printf", "vim", "vimdoc", "query" },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = { "javascript" },

    ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
    -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = { "c", "rust" },
        -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
        disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
                return true
            end
        end,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
    },
    indent = {
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ["af"] = "@function.outer",
                ["kf"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["kc"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                ["kl"] = { query = "@loop.inner", desc = "Select inner part of a loop region" },
                ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop region" },
                ["kt"] = { query = "@conditional.inner", desc = "Select inner part of a conditional region" },
                ["at"] = { query = "@conditional.outer", desc = "Select outer part of a conditional region" },
                ["ka"] = { query = "@assignment.inner", desc = "Select inner part of a assignment region" },
                ["aa"] = { query = "@assignment.outer", desc = "Select outer part of a assignment region" },
                ["km"] = { query = "@comment.inner", desc = "Select inner part of a comment region" },
                ["am"] = { query = "@comment.outer", desc = "Select outer part of a comment region" },
                ["kg"] = { query = "@parameter.inner", desc = "Select inner part of a parameter region" },
                ["ag"] = { query = "@parameter.outer", desc = "Select outer part of a parameter region" },
            },
            selection_modes = {
                ['@comment.outer'] = "V", -- v V <c-v>
                ['@scope'] = "<c-v>",
                -- etc.
            },
            include_surrounding_whitespace = false
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                ["<leader>]f"] = { query = "@function.outer", desc = "Goto next function" },
                ["<leader>]c"] = { query = "@class.outer", desc = "Goto next class" },
                ["<leader>]l"] = { query = "@loop.*", desc = "Goto next loop" },
                ["<leader>]s"] = { query = "@scope", query_group = "locals", desc = "Goto next scope" },
                ["<leader>]z"] = { query = "@fold", query_group = "folds", desc = "Goto next scope" },
            },
            goto_next_end = {
                ["<leader>]F"] = { query = "@function.outer", desc = "Goto next function" },
                ["<leader>]C"] = { query = "@class.outer", desc = "Goto next class" },
            },
            goto_previous_start = {
                ["<leader>[f"] = { query = "@function.outer", desc = "Goto previous function" },
                ["<leader>[c"] = { query = "@class.outer", desc = "Goto previous class" },
            },
            goto_previous_end = {
                ["<leader>[F"] = { query = "@function.outer", desc = "Goto previous function" },
                ["<leader>[C"] = { query = "@class.outer", desc = "Goto previous class" },
            },
            goto_next = {
                ["<leader>]t"] = { query = "@conditional.outer", desc = "Goto next conditional" },
            },
            goto_previous = {
                ["<leader>[t"] = { query = "@conditional.outer", desc = "Goto previous conditional" },
            }
        }
    }
}

M.context = {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'topline',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20, -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

return M
