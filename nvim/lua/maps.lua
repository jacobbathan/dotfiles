
-- Functional wrapper for mapping custom keybindings
function map(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<space>", "<nop>")
vim.g.mapleader = ' '

map("n", "<Leader>bn", ":bn<cr>")
map("n", "<Leader>tn", "gt")
