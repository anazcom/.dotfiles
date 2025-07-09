---@type LazyPluginSpec
return {
	"tpope/vim-fugitive",
	keys = {
		{ "n", "<leader>gs", ":Git<CR>", { noremap = true, silent = true } },
	},
}
