local actions = require("telescope.actions")
return {
	"nvim-telescope/telescope.nvim",
	opts = {
		defaults = {
			layout_strategy = "horizontal",
			layout_config = { prompt_position = "top" },
			sorting_strategy = "ascending",
			winblend = 0,
		},
		pickers = {
			oldfiles = {
				cwd = vim.fn.expand("%:p:h"),
				cwd_only = true,
			},
		},
	},
}
