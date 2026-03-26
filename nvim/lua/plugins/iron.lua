return {
	{
		"Vigemus/iron.nvim",
		event = "VeryLazy",
		config = function()
			local iron = require("iron.core")
			local view = require("iron.view")
			local common = require("iron.fts.common")

			iron.setup({
				config = {
					scratch_repl = true,
					repl_open_cmd = view.split.vertical.botright(0.4),
					repl_definition = {
						python = {
							command = { "ipython" },
							format = common.bracketed_paste_python,
						},
						r = {
							command = { "radian" },
							format = common.bracketed_paste,
						},
					},
				},
				keymaps = {
					send_motion = "<localleader>rs",
					send_line = "<localleader>rr",
					send_paragraph = "<localleader>rp",
					send_file = "<localleader>rf",
					send_code_block = "<localleader>rb",
					send_code_block_and_move = "<localleader>rn",
					toggle_repl = "<localleader>ri",
					exit = "<localleader>rq",
					clear = "<localleader>rx",
				},
				highlight = {
					italic = true,
				},
				ignore_blank_lines = true,
			})
		end,
	},
}
