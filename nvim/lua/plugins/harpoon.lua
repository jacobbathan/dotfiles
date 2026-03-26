return {
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		event = "VeryLazy",
		config = function()
			local harpoon = require("harpoon")
			local map = require("utils.safe_keymap")

			harpoon:setup()

			local function toggle_menu()
				local has_telescope = pcall(require, "telescope")
				if not has_telescope then
					harpoon.ui:toggle_quick_menu(harpoon:list())
					return
				end

				local conf = require("telescope.config").values
				local finders = require("telescope.finders")
				local pickers = require("telescope.pickers")
				local actions = require("telescope.actions")
				local action_state = require("telescope.actions.state")

				local items = {}
				for index, item in ipairs(harpoon:list().items) do
					if item.value then
						items[#items + 1] = {
							index = index,
							value = item.value,
						}
					end
				end

				pickers.new({}, {
					prompt_title = "Harpoon",
					finder = finders.new_table({
						results = items,
						entry_maker = function(entry)
							return {
								value = entry,
								display = string.format("%d %s", entry.index, entry.value),
								ordinal = entry.value,
							}
						end,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
					attach_mappings = function(prompt_bufnr)
						actions.select_default:replace(function()
							local selection = action_state.get_selected_entry()
							actions.close(prompt_bufnr)
							if selection and selection.value then
								harpoon:list():select(selection.value.index)
							end
						end)
						return true
					end,
				}):find()
			end

			map.set("n", "<leader>a", function()
				harpoon:list():add()
			end, { desc = "Harpoon Add File" })
			map.set("n", "<C-e>", toggle_menu, { desc = "Harpoon Menu" })
			map.set("n", "<C-h>", function()
				harpoon:list():select(1)
			end, { desc = "Harpoon File 1" })
			map.set("n", "<C-t>", function()
				harpoon:list():select(2)
			end, { desc = "Harpoon File 2" })
			map.set("n", "<C-n>", function()
				harpoon:list():select(3)
			end, { desc = "Harpoon File 3" })
			map.set("n", "<C-s>", function()
				harpoon:list():select(4)
			end, { desc = "Harpoon File 4" })
		end,
	},
}
