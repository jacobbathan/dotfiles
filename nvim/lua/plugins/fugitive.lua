return {
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		config = function()
			local map = require("utils.safe_keymap")

			map.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git Status" })
			map.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git Blame" })
			map.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git Diff Split" })
		end,
	},
}
