local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", builtin.find_files, {})
vim.keymap.set("n", "<leader>gf", builtin.git_files, {})

vim.keymap.set('n', '<leader>sf', function()
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 0,
        previewer = false,
    })
end, { desc = '[S]earch [F]uzzily?' });
