vim.keymap.set('n', '<Leader>;f', ':Telescope find_files<CR>')
vim.keymap.set('n', '<Leader>;gc', ':Telescope git_commits<CR>')
-- vim.keymap.set('n', '<Leader>;gc', ':Telescope grep_string search=')
vim.keymap.set('n', '<Leader>;r', ':Telescope live_grep<CR>')
vim.keymap.set('n', '<Leader>//', ':Telescope buffers<CR>')
vim.keymap.set('n', '<Leader>;;', ':Telescope help_tags<CR>')


require('telescope').setup {
    defaults = {
        prompt_prefix = "$ "
    }
}

require('telescope').load_extension('fzf')

