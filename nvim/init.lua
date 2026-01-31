-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Plugins
vim.pack.add({
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        branch = "main",
        build = ":TSUpdate"
    },
    { src = "https://github.com/sainnhe/gruvbox-material" },
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    {
        src = "https://github.com/Saghen/blink.cmp",
        version = vim.version.range("*"),
    },
})

-- Themes
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox-material")

-- Syntax Highlight
require("nvim-treesitter").install(
    { "lua", "vim", "python", "javascript", "java" }
)

-- Mason
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup(
    { ensure_installed = { "basedpyright", "ruff", "jdtls", "lua_ls" } }
)

-- Completion
require("blink.cmp").setup({ keymap = { preset = "super-tab" } })

-- Mini
require("mini.pairs").setup()
require("mini.pick").setup()
require("mini.surround").setup()
require("mini.comment").setup()

-- LSP
vim.keymap.set("n", "J", vim.diagnostic.open_float)
vim.lsp.config("jdtls", { -- Set java runtime for lsp to version 21
    cmd = {
        "env",
        "JAVA_HOME=" .. vim.fn.expand("~/.sdkman/candidates/java/21.0.9-tem"),
        vim.fn.exepath("jdtls"),
    },
})

-- Mini Pick
vim.keymap.set("n", "<leader>f", MiniPick.builtin.files)

-- Comments (mini.comment)
vim.keymap.set("n", "<C-/>", "gcc", { remap = true })
vim.keymap.set("v", "<C-/>", "gc", { remap = true })

-- Formatting
vim.keymap.set("n", "<leader>t", vim.lsp.buf.format)

-- Binds
vim.keymap.set("n", "<leader>o", ":update<cr> :source<cr>")
vim.keymap.set("n", "<leader>w", ":update<cr>")
vim.keymap.set("n", "<leader>W", ":write<cr>")
vim.keymap.set("n", "<leader>x", ":quit<cr>")
vim.keymap.set("n", "<leader>ef", function()
    vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua")
end, { desc = "Open Neovim config" })

-- Visuals
vim.opt.wrap = false
vim.opt.colorcolumn = "80"
vim.opt.termguicolors = true
vim.opt.list = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.winborder = "rounded"
vim.opt.signcolumn = "yes"

-- Behaviors
vim.opt.mouse = "a"
vim.opt.undofile = true
vim.opt.swapfile = false

-- Tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.smartindent = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"
vim.g.clipboard = { -- Fix for wayland clipboard ghost window hijacking focus
    name = "OSC 52",
    copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
        ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
        ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
    },
}

-- Copying
vim.keymap.set("n", "Y", "yy")
vim.keymap.set("n", "<leader>y", "y$")

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking",
    group = vim.api.nvim_create_augroup(
        "kickstart-highlight-yank",
        { clear = true }
    ),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- Auto Save
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
    desc = "Auto-save on focus change or buffer leave",
    callback = function()
        vim.cmd("silent! update")
    end,
})

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.keymap.set("n", "<leader>h", "<cmd>nohlsearch<cr>") -- clear highlights
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Window Navigation
vim.opt.splitright = true
vim.keymap.set("n", "<C-`>", "<cmd>vsplit | terminal<cr>")
vim.keymap.set("n", "<C-\\>", "<cmd>vsplit<cr>")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- Terminal
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- Visual Mode Indents
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Select Binds
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")

-- Navigation
vim.opt.scrolloff = 8
vim.keymap.set("n", "<leader>d", "<C-d>zz")
vim.keymap.set("n", "<leader>u", "<C-u>zz")
