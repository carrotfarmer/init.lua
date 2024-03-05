local builtin = require("telescope.builtin")
local telescope = require("telescope")

telescope.setup({
    extensions = {
        file_browser = {
            initial_mode = "normal",
            hijack_netrw = true
        }
    }
})

telescope.load_extension "file_browser"

vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>gf", builtin.git_files, {})

-- grep search
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })

vim.keymap.set('n', '<leader>sf', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
    })
end, { desc = '[S]earch [F]uzzily?' });
