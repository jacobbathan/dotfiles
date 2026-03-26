return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				search = {
					enabled = true,
					exclude = { "help", "neo-tree", "TelescopePrompt", "TelescopeResults" },
				},
			},
		},
		config = function(_, opts)
			require("flash").setup(opts)

			local map = require("utils.safe_keymap")
			local disabled_filetypes = {
				help = true,
				["neo-tree"] = true,
				TelescopePrompt = true,
				TelescopeResults = true,
			}

			local function enabled()
				return not disabled_filetypes[vim.bo.filetype]
			end

			map.set("n", "<leader>s", function()
				if not enabled() then
					return
				end
				require("flash").jump()
			end, { desc = "Flash Search" })

			map.set("n", "<leader>S", function()
				if not enabled() then
					return
				end
				require("flash").treesitter_search()
			end, { desc = "Flash Treesitter Search" })

			map.set("o", "r", function()
				if not enabled() then
					return
				end
				require("flash").remote()
			end, { desc = "Remote Flash" })
		end,
	},
}
