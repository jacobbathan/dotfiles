
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

map("n", "<leader>bn", ":bn<cr>")
map("n", "<leader>tn", "gt")

-- Stolen from the primeagen, search and replace on word
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")
