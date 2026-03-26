return {
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
			"Vigemus/iron.nvim",
		},
		event = "VeryLazy",
		config = function()
			local map = require("utils.safe_keymap")
			local runner = require("quarto.runner")

			require("otter").setup({
				lsp = {
					diagnostic_update_events = { "BufWritePost" },
				},
			})

			require("quarto").setup({
				lspFeatures = {
					enabled = true,
					languages = { "r", "python", "julia", "bash" },
					diagnostics = {
						enabled = true,
						triggers = { "BufWritePost" },
					},
				},
				codeRunner = {
					enabled = true,
					default_method = "iron",
				},
			})

			map.set("n", "<leader>qp", "<cmd>QuartoPreview<CR>", { desc = "Quarto Preview" })
			map.set("n", "<leader>qq", "<cmd>QuartoClosePreview<CR>", { desc = "Quarto Close Preview" })
			map.set("n", "<localleader>rc", runner.run_cell, { desc = "Quarto Run Cell", silent = true })
			map.set("n", "<localleader>ra", runner.run_above, { desc = "Quarto Run Cell And Above", silent = true })
			map.set("n", "<localleader>rA", runner.run_all, { desc = "Quarto Run All Cells", silent = true })
			map.set("n", "<localleader>rl", runner.run_line, { desc = "Quarto Run Line", silent = true })
			map.set("n", "<localleader>rR", function()
				runner.run_all(true)
			end, { desc = "Quarto Run All Languages", silent = true })
		end,
	},
}
