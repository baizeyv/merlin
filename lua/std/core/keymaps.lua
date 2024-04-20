local M = {}

-- vim.api.nvim_set_keymap(mode, lhs, rhs, opts) 用于设置映射
-- mode -> 模式字符串 "n" ...
-- lhs -> 左手键
-- rhs -> 右手键 (行为)
-- opts -> 选项
-- 其中 opts 包含以下内容
-- noremap -> bool, 是否禁用递归重映射
-- silent -> bool, 是否禁止输出映射命令
-- expr -> bool, true->rhs被解释为表达式
-- script -> bool, true->映射仅在当前脚本中有效
-- buffer -> bool, true->映射仅在当前缓冲区中有效
-- nowait -> bool, 表示是否立即执行映射 true->映射不会等待下一个键的按下 默认false
-- desc 自定义的

-- n -> 普通模式
-- v -> 可视模式
-- i -> 插入模式
-- c -> 命令行模式
-- s -> 选择模式
-- x -> 可视模式 visual block mode
-- o -> 操作符待定模式
-- t -> 终端模式

M.keybinds = {
    -- all mode
    [""] = {
        ["u"] = { "k", { noremap = true, silent = true, nowait = true, desc = "Move Up" } },
        ["e"] = { "j", { noremap = true, silent = true, nowait = true, desc = "Move Down" } },
        ["n"] = { "h", { noremap = true, silent = true, nowait = true, desc = "Move Left" } },
        ["i"] = { "l", { noremap = true, silent = true, nowait = true, desc = "Move Right" } },
        ["U"] = { "5k", { noremap = true, silent = true, nowait = true, desc = "Move Up 5x" } },
        ["E"] = { "5j", { noremap = true, silent = true, nowait = true, desc = "Move Down 5x" } },
        ["N"] = { "0", { noremap = true, silent = true, nowait = true, desc = "Move To Begin Of Line" } },
        ["I"] = { "$", { noremap = true, silent = true, nowait = true, desc = "Move To End Of Line" } },
        ["W"] = { "5w", { noremap = true, silent = true, nowait = true, desc = "Next Word" } },
        ["B"] = { "5b", { noremap = true, silent = true, nowait = true, desc = "Previous Word" } },
        ["h"] = { "e", { noremap = true, silent = true, nowait = true, desc = "" } },
        ["<leader>,."] = { "%", { noremap = true, silent = true, desc = "Match Symbol" } },
        ["<C-u>"] = { "5<C-y>", { noremap = true, silent = true, desc = "Scroll Up" } },
        ["<C-e>"] = { "5<C-e>", { noremap = true, silent = true, desc = "Scroll Down" } },
    },
    -- normal mode
    n = {
        [";"] = { ":", { desc = "Toggle Command Line" } },
        ["S"] = { ":w<cr>", { desc = "Save Current File" } },
        ["Q"] = { ":q<cr>", { desc = "Quit Neovim" } },
        ["l"] = { "u", { noremap = true, silent = true, nowait = true, desc = "undo" } },
        ["k"] = { "i", { noremap = true, silent = true, nowait = true, desc = "insert" } },
        ["K"] = { "I", { noremap = true, silent = true, nowait = true, desc = "insert at begin of line" } },
        ["<leader><cr>"] = { ":nohlsearch<cr>", { silent = true, desc = "no highlight search" } },
        ["<leader>o"] = { "za", { noremap = true, silent = true, desc = "fold code" } },
        ["."] = { "n", { noremap = true, silent = true, nowait = true, desc = "search next" } },
        [","] = { "N", { noremap = true, silent = true, nowait = true, desc = "search previous" } },
        ["<space>"] = { "<nop>", { desc = "no space" } },

        ["su"] = { ":set nosplitbelow<cr>:split<cr>:set splitbelow<cr>", { silent = true, desc = "split up" } },
        ["se"] = { ":set splitbelow<cr>:split<cr>", { silent = true, desc = "split down" } },
        ["sn"] = { ":set nosplitright<cr>:vsplit<cr>:set splitright<cr>", { silent = true, desc = "split left" } },
        ["si"] = { ":set splitright<cr>:vsplit<cr>", { silent = true, desc = "split right" } },
        ["<leader>u"] = { "<C-w>k", { noremap = true, silent = true, desc = "select up" } },
        ["<leader>e"] = { "<C-w>j", { noremap = true, silent = true, desc = "select down" } },
        ["<leader>n"] = { "<C-w>h", { noremap = true, silent = true, desc = "select left" } },
        ["<leader>i"] = { "<C-w>l", { noremap = true, silent = true, desc = "select right" } },
        ["<leader>w"] = { "<C-w>w", { noremap = true, silent = true, desc = "select next" } },

        ["<"] = { "<<", { noremap = true, silent = true, nowait = true, desc = "indent left" } },
        [">"] = { ">>", { noremap = true, silent = true, nowait = true, desc = "indent right" } },

        ["<leader>bi"] = { ":bnext<cr>", { silent = true, desc = "next buffer" } },
        ["<leader>bn"] = { ":bprevious<cr>", { silent = true, desc = "previous buffer" } },
        ["P"] = { '"_dP', { noremap = true, silent = true, desc = "paste" } }
    },
    v = {
        ["Y"] = { "\"+y", { silent = true, desc = "yank" } },
        ["<"] = { "<gv", { noremap = true, silent = true, nowait = true, desc = "indent left" } },
        [">"] = { ">gv", { noremap = true, silent = true, nowait = true, desc = "indent right" } },
        ["<A-e>"] = { ":m .+1<cr>==", { silent = true, desc = "move current line to below" } },
        ["<A-u>"] = { ":m .-2<cr>==", { silent = true, desc = "move current line to above" } },
        ["P"] = { '"_dP', { noremap = true, silent = true, desc = "paste" } },
        ["k"] = { "i", { noremap = true, silent = true, nowait = true, desc = "insert" } },
        ["K"] = { "I", { noremap = true, silent = true, nowait = true, desc = "insert at begin of line" } },
    },
    i = {

    },
    c = {
        ["<A-i>"] = { "<Right>", { noremap = true, desc = "" } },
        ["<A-n>"] = { "<Left>", { noremap = true, desc = "" } },
        ["<A-u>"] = { "<Up>", { noremap = true, desc = "" } },
        ["<A-e>"] = { "<Down>", { noremap = true, desc = "" } }
    },
    x = { -- visual block mode
        ["<A-e>"] = { ":move '>+1<cr>gv-gv", { silent = true, desc = "..." } },
        ["<A-u>"] = { ":move '<-2<cr>gv-gv", { silent = true, desc = "..." } },
        ["k"] = { "i", { noremap = true, silent = true, nowait = true, desc = "insert" } },
        ["K"] = { "I", { noremap = true, silent = true, nowait = true, desc = "insert at begin of line" } },
    },
    t = {

    }
}

M.load_keymaps = function ()
    vim.schedule(function ()
        local function set_map(map_values)
            for mode, mode_values in pairs(map_values) do
                if mode_values ~= nil then
                    for keybind, mapping_info in pairs(mode_values) do
                        local rhs = mapping_info[1]
                        local opt = mapping_info[2]
                        vim.api.nvim_set_keymap(mode, keybind, rhs, opt)
                    end
                end
            end
        end
        set_map(M.keybinds)
    end)
end

return M
