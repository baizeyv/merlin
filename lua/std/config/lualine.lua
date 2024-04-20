-- default options
-- return {
--     options = {
--         icons_enabled = true,
--        theme = "auto",
--         component_separators = { left = "", right = "" },
--         section_separators = { left = "", right = "" },
--         disabled_filetypes = {
--             statusline = {},
--             winbar = {}
--         },
--         ignore_focus = {},
--         always_divide_middle = true,
--         globalstatus = false,
--         refresh = {
--             statusline = 1000,
--             tabline = 1000,
--             winbar = 1000
--         }
--     },
--     sections = {
--         lualine_a = {'mode'},
--         lualine_b = {'branch', 'diff', 'diagnostics'},
--         lualine_c = {'filename'},
--         lualine_x = {'encoding', 'fileformat', 'filetype'},
--         lualine_y = {'progress'},
--         lualine_z = {'location'}
--     },
--     inactive_sections = {
--         lualine_a = {},
--         lualine_b = {},
--         lualine_c = {'filename'},
--         lualine_x = {'location'},
--         lualine_y = {},
--         lualine_z = {}
--     },
--     tabline = {},
--     winbar = {},
--     inactive_winbar = {},
--     extensions = {}
-- }

local lualine = require("lualine")

-- Color table for highlights
local colors = {
    bg = "#202328",
    fg = "#bbc2cf",
    yellow = "#ecbe7b",
    cyan = "#008080",
    darkblue = "#081633",
    green = "#98be65",
    orange = "#ff8800",
    violet = "#a9a1e1",
    magenta = "#c678dd",
    blue = "#51afef",
    red = "#ec5f67"
}

local conditions = {
    buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
    end,
    hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end,
    check_git_workspace = function()
        local filepath = vim.fn.expand("%:p:h")
        local gitdir = vim.fn.finddir(".git", filepath .. ";")
        return gitdir and #gitdir > 0 and #gitdir < #filepath
    end
}

-- Config
local config = {
    options = {
        -- Disable sections and component separators
        component_separators = '',
        section_separators = '',
        theme = {
            -- We are going to use lualine_c and lualine_x as left and right section.
            -- Both are highlighted by c theme.
            -- So we are just setting default lookm o statusline
            normal = {
                c = { fg = colors.fg, bg = colors.bg },
            },
            inactive = {
                c = { fg = colors.fg, bg = colors.bg }
            }
        }
    },
    sections = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- these will be filled later
        lualine_c = {},
        lualine_x = {}
    },
    inactive_sectioons = {
        -- these are to remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
    }
}

local mode_color = {
    n = colors.red,
    i = colors.green,
    v = colors.blue,
    [''] = colors.blue,
    V = colors.blue,
    c = colors.magenta,
    no = colors.red,
    s = colors.orange,
    S = colors.orange,
    [''] = colors.orange,
    ic = color,yellow,
    R = colors.violet,
    Rv = colors.violet,
    cv = colors.red,
    ce = colors.red,
    r = colors.cyan,
    rm = colors.cyan,
    ['r?'] = colors.cyan,
    ['!'] = colors.red,
    t = colors.red
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
    table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
    table.insert(config.sections.lualine_x, component)
end

ins_left {
    function()
        return '▊'
    end,
    color = { fg = colors.blue }, -- sets highlighting of component
    padding = { left = 0, right = 1 }
}

ins_left {
    -- mode component
    function()
        return ''
    end,
    color = function()
        -- auto cchange color according to neovim mode
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 }
}

ins_left {
    'mode',
    color = function()
        return { fg = mode_color[vim.fn.mode()] }
    end,
    padding = { right = 1 }
}

ins_left {
    'filename',
    cond = conditions.buffer_not_empty,
    color = { fg = colors.magenta, gui = 'bold' }
}

ins_left {
    'branch',
    icon = '',
    color = { fg = colors.violet, gui = 'bold' }
}

ins_left {
    'diff',
    -- Is it me or the symbol for modified us really weird
    symbols = {
        added = ' ',
        modified = '󰝤 ',
        removed = ' '
    },
    diff_color = {
        added = { fg = colors.green },
        modified = { fg = colors.orange },
        removed = { fg = colors.red }
    },
    cond = conditions.hide_in_width
}

ins_left {
    'diagnostics',
    sources = { 'nvim_diagnostic' },
    symbols = { error = ' ', warn = ' ', info = ' ' },
    diagnostics_color = {
        color_error = { fg = colors.red },
        color_warn = { fg = colors.yellow },
        color_info = { fg = colors.cyan }
    }
}

ins_left {
    function()
        return '%='
    end
}

ins_left {
    -- lsp server name .
    function()
        local msg = "No Active Lsp"
        local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
        local clients = vim.lsp.get_active_clients()
        if next(clients) == nil then
            return msg
        end
        for _, client in ipairs(clients) do
            local filetypes = client.config.filetypes
            if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                return client.name
            end
        end
        return msg
    end,
    icon = ' LSP:',
    color = { fg = '#ffffff', gui = 'bold' }
}

ins_right {
    'location'
}

ins_right {
    'filesize',
    cond = conditions.buffer_not_empty
}

ins_right {
    'o:encoding', -- option component same as &encoding in viml
    fmt = string.upper,
    cond = conditions.hide_in_width,
    color = { fg = colors.green, gui = 'bold' }
}

ins_right {
    function()
        local symbols = {
          unix = '', -- e712
          dos = '', -- e70f
          mac = '', -- e711
        }
        local format = vim.bo.fileformat
        return symbols[format] .. " " .. string.upper(format)
    end,
    color = { fg = colors.green, gui = 'bold' }
}

ins_right {
    'progress',
    color = { fg = colors.fg, gui = 'bold' }
}

ins_right {
    function()
        return '▊' 
    end,
    color = { fg = colors.blue },
    padding = { left = 1, right = 0 }
}

return config
