return {
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = "VeryLazy",
		config = function()
			local list_file = vim.fn.stdpath("config") .. "/mason-packages.txt"
			local ensure = {}
			if vim.fn.filereadable(list_file) == 1 then
				ensure = vim.fn.readfile(list_file)
			end

			-- Always ensure a minimal baseline is present even on first run
			local baseline = {
				-- LSPs
				"lua-language-server",
				-- formatters/linters/tools you commonly want can be added here as safe defaults
			}
			-- Merge baseline into ensure without duplicates
			local seen = {}
			for _, n in ipairs(ensure) do seen[n] = true end
			for _, n in ipairs(baseline) do if not seen[n] then table.insert(ensure, n) end end

			require("mason-tool-installer").setup({
				ensure_installed = ensure,
				auto_update = false,
				run_on_start = true, -- install on fresh machines
				start_delay = 200, -- slight delay to allow Mason to init
				debounce_hours = nil,
			})
		end,
	},
}
