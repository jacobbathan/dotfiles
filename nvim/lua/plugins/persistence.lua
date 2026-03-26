return {
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {},
		config = function(_, opts)
			require("persistence").setup(opts)

			local map = require("utils.safe_keymap")
			map.set("n", "<leader>qs", function()
				require("persistence").load()
			end, { desc = "Session Restore Dir" })
			map.set("n", "<leader>ql", function()
				require("persistence").load({ last = true })
			end, { desc = "Session Restore Last" })
			map.set("n", "<leader>qd", function()
				require("persistence").stop()
			end, { desc = "Session Stop Saving" })
		end,
	},
}
