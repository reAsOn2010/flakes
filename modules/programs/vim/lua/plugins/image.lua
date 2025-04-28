return {
	"3rd/image.nvim",
	enabled = true,
	event = "VeryLazy",
	opts = {
		backend = "ueberzug",
		processor = "magick_cli", -- "magick_cli" or "magick_rock"
		integrations = {
			markdown = {
				enabled = false,
			},
			neorg = {
				enabled = false,
			},
			typst = {
				enabled = false,
			},
			html = {
				enabled = false,
			},
			css = {
				enabled = false,
			},
		},
	},
}
