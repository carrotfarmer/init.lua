local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.5',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        config = function()
            vim.keymap.set(
                "n",
                "<leader>b",
                ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
                { noremap = true, desc = "Open File Explorer" }
            )
        end
    },
    { 'rose-pine/neovim',                name = 'rose-pine' },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "ThePrimeagen/harpoon" },
    { "tpope/vim-fugitive" },
    { "andweeb/presence.nvim" },

    -- very important
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {
            open_mapping = [[<C-\>]]
        }
    },

    -- lsp stuff
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'VonHeikemen/lsp-zero.nvim',        branch = 'v3.x' },
    { 'neovim/nvim-lspconfig' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/nvim-cmp' },
    { 'L3MON4D3/LuaSnip' },
    { "github/copilot.vim" },
    { 'RaafatTurki/hex.nvim' },

    -- for commenting
    { 'numToStr/Comment.nvim',            opts = {} },


    { 'wakatime/vim-wakatime',            lazy = false },


    require("carrotfarmer.autofmt")
})

-- Comment.nvim remaps
local comment_api = require("Comment.api")

vim.keymap.set('n', '<leader>/', comment_api.toggle.linewise.current, { desc = '[/] Comment line' })
vim.keymap.set('v', '<leader>/b', comment_api.toggle.blockwise.current, { desc = '[b] Comment block' })
