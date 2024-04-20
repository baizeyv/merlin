-- :help options
local M = {}

M.normal = {
    autochdir = true, -- auto change directory to current path
	backup = false, -- creates a backup file
	cmdheight = 2, -- more space in the neovim command line for displaying messages
	completeopt = { "longest", "noinsert", "menuone", "noselect", "preview" },
	inccommand = "split",
	conceallevel = 0, -- so that `` is visible in markdown files
	cursorline = true,
    cursorlineopt = "number",
	exrc = true,
	fileencoding = "utf-8", -- the encoding written to a file
	hlsearch = true, -- highlight all matches on previous search pattern
	ignorecase = true, -- ignore case in search patterns
	number = true, -- set numbered lines
    numberwidth = 2,
	relativenumber = true, -- set relative numbered lines
	expandtab = true, -- convert tabs to spaces
	tabstop = 4, -- insert 4 spaces for a tab
	shiftwidth = 4, -- the number of spaces inserted for each indentation
	softtabstop = 4,
	list = true,
	scrolloff = 10,
	ttimeoutlen = 0,
	timeout = false,
	wrap = true,
	foldmethod = "indent",
	foldlevel = 99,
	foldenable = true,
	timeoutlen = 400,
	mouse = "a",
	pumheight = 10, -- pop up menu height
	showmode = false,
	showtabline = 2, -- always show tabs
	smartcase = true,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	swapfile = false,
	undofile = true,
	updatetime = 250,
	writebackup = false,
	signcolumn = "yes",
	lazyredraw = true,
	virtualedit = "block",
    laststatus = 3,
    clipboard = "unnamedplus",
    ruler = false,
	termguicolors = true
}

M.append = {
    -- NOTE: when wrap is off, the `extends` will validate
	listchars = "eol:↴,tab:⇥ ,extends:›,trail:▫",
	shortmess = "c",
	whichwrap = "<>[]hl",
	iskeyword = "-"
}

local provider = {
	"loaded_node_provider",
	"loaded_python3_provider",
	"loaded_perl_provider",
	"loaded_ruby_provider"
}

local function disable_providers(tb)
	for _, v in ipairs(tb) do
		vim.g[v] = 0
	end
end

M.load_options = function ()
	vim.g.toggle_theme_icon = "   "
    local function set_opt(normal_tb, append_tb)
        for k, v in pairs(normal_tb) do
            vim.opt[k] = v
        end
        for k, v in pairs(append_tb) do
            vim.opt[k]:append(v)
        end
    end
    set_opt(M.normal, M.append)

	disable_providers(provider)

	-- add binaries installed by mason.nvim to path
	local is_windows = vim.fn.has("win32") ~= 0
	vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH
end

return M