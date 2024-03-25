return {
	"neovim/nvim-lspconfig",
	opts = {
		servers = {
			lua_ls = {
				settings = {
					Lua = {
						workspace = {
							checkThirdParty = false,
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
			gopls = {},
			nixd = {},
			-- nil_ls = {},
			yamlls = {
				settings = {
					yaml = {
						trace = {
							server = "verbose",
						},
						keyOrdering = true,
						schemas = {
							-- ["/home/yakumo/Documents/github/kubernetes-json-schema/v1.24.17-local/all.json"] = "/*.k8s.yaml",
							-- ["kubernetes"] = "/*k8s*.yaml",
							["https://json.schemastore.org/kustomization"] = "kustomizaiton.yaml",
						},
					},
				},
			},
		},
	},
}
