local previewers = require("telescope.previewers")
local Job = require("plenary.job")
local previewer_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    opts = opts or {}
    Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
            local mime_type = vim.split(j:result()[1], "/")[1]
            if mime_type == "text" then
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
            else
                vim.schedule(function()
                    vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "<BINARY>" })
                end)
            end
        end
    }):sync()
end

local actions = require('telescope.actions')

local function empty()
    -- nothing to do
end

local M = {
    defaults = {
        mappings = {
            n = {
                ['e'] = actions.move_selection_next,
                ['E'] = actions.move_selection_next + actions.move_selection_next + actions.move_selection_next + actions.move_selection_next + actions.move_selection_next,
                ['j'] = empty,
                ['u'] = actions.move_selection_previous,
                ['U'] = actions.move_selection_previous + actions.move_selection_previous + actions.move_selection_previous + actions.move_selection_previous + actions.move_selection_previous,
                ['k'] = empty,
                ['q'] = actions.close,
                ['<Esc>'] = empty,
                ["H"] = actions.move_to_top,
                ["L"] = actions.move_to_bottom,
                ["M"] = actions.move_to_middle,
                ["gg"] = actions.move_to_top,
                ["G"] = actions.move_to_bottom,
                ['<leader>a'] = actions.select_all,
                ['<leader>s'] = actions.add_selection,
                ['<leader>r'] = actions.remove_selection,
                ['<leader>t'] = actions.toggle_selection,
                ['<CR>'] = actions.select_default,
                ['<A-CR>'] = actions.select_vertical,
                ['<C-CR>'] = actions.select_horizontal,
                ['<S-CR>'] = actions.select_tab,
                ['<A-e>'] = actions.preview_scrolling_down,
                ['<A-u>'] = actions.preview_scrolling_up,
                ['<A-n>'] = actions.preview_scrolling_left,
                ['<A-i>'] = actions.preview_scrolling_right,
                ['<C-n>'] = actions.results_scrolling_left,
                ['<C-i>'] = actions.results_scrolling_right,
                ["<up>"] = actions.cycle_history_prev,
                ["<down>"] = actions.cycle_history_next
            },
            i = {
                ['<C-e>'] = actions.move_selection_next,
                ['<C-u>'] = actions.move_selection_previous,
                ['<C-n>'] = actions.results_scrolling_left,
                ['<C-i>'] = actions.results_scrolling_right,
                ['<C-c>'] = actions.close,
                ['<A-e>'] = actions.preview_scrolling_down,
                ['<A-u>'] = actions.preview_scrolling_up,
                ['<A-n>'] = actions.preview_scrolling_left,
                ['<A-i>'] = actions.preview_scrolling_right,
                ['<C-a>'] = actions.select_all,
                ['<C-s>'] = actions.add_selection,
                ['<C-r>'] = actions.remove_selection,
                ['<C-t>'] = actions.toggle_selection,
                ["<up>"] = actions.cycle_history_prev,
                ["<down>"] = actions.cycle_history_next
            }
        },
        layout_strategy = "horizontal",
        sorting_strategy = "ascending",
        layout_config = {
            height = 0.9,
            width = 0.9,
            preview_cutoff = 100,
            preview_width = 0.6,
            prompt_position = "top",
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
    },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
        find_files = {
            previewer = false,
            layout_config = {
                height = 0.7,
                width = 0.7,
                prompt_position = "top",
            },
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case'
        }
    }
}

return M
