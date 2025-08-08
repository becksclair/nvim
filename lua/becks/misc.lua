local B = {}

function B.RunningOnVConsole()
		if vim.env.TERM == 'linux' then
				return true
		end
		return false
end

function B.EchoMultiline(msg)
	for _, s in ipairs(vim.fn.split(msg, "\n")) do
		vim.cmd("echom '" .. s:gsub("'", "''") .. "'")
	end
end

function B.Info(msg)
	vim.cmd("echohl Directory")
	B.EchoMultiline(msg)
	vim.cmd("echohl None")
end

function B.Warn(msg)
	vim.cmd("echohl WarningMsg")
	B.EchoMultiline(msg)
	vim.cmd("echohl None")
end

function B.Err(msg)
	vim.cmd("echohl ErrorMsg")
	B.EchoMultiline(msg)
	vim.cmd("echohl None")
end

function B.SudoExecNoPasswd(cmd, print_output)
	local out = vim.fn.system(string.format("sudo %s", cmd))

	if vim.v.shell_error ~= 0 then
		print("\n")
		B.Err(out)
		return false
	end
	if print_output then print("\n", out) end
	return true
end

function B.SudoExec(cmd, print_output)
	vim.fn.inputsave()
	local password = vim.fn.inputsecret("Password: ")
	vim.fn.inputrestore()

	if not password or #password == 0 then
		B.Warn("Invalid password, sudo aborted")
		return false
	end

	local out = vim.fn.system(string.format("sudo -p '' -S %s", cmd), password)

	if vim.v.shell_error ~= 0 then
		print("\n")
		B.Err(out)
		return false
	end
	if print_output then print("\n", out) end
	return true
end

function B.hello()
	local pos = vim.api.nvim_win_get_cursor(0)[2]
	local line = vim.api.nvim_get_current_line()
	local nline = line:sub(0, pos) .. 'hello' .. line:sub(pos + 1)
	vim.api.nvim_set_current_line(nline)
end

function B.SudoWrite(tmpfile, filepath)
	vim.cmd('echo "Write with sudo"')
	if not tmpfile then tmpfile = vim.fn.tempname() end
	if not filepath then filepath = vim.fn.expand("%") end
	if not filepath or #filepath == 0 then
		B.Err("E32: No file name")
		return
	end

	-- `bs=1048576` is equivalent to `bs=1M` for GNU dd or `bs=1m` for BSD dd

	-- Both `bs=1M` and `bs=1m` are non-POSIX
	local cmd = string.format("dd if=%s of=%s bs=1048576",
		vim.fn.shellescape(tmpfile),
		vim.fn.shellescape(filepath))

	-- no need to check error as this fails the entire function
	vim.api.nvim_exec2(string.format("write! %s", tmpfile), { output = true })

	if B.SudoExecNoPasswd(cmd) then
		B.Info(string.format([[  "%s" written]], filepath))
		vim.cmd("e!")
	end
	vim.fn.delete(tmpfile)
end

function B.root_pattern_excludes(opt)
	local util = require('lspconfig.util')

	local root = opt.root
	local exclude = opt.exclude

	local function matches(path, pattern)
		return 0 < #vim.fn.glob(util.path.join(path, pattern))
	end

	return function(startpath)
		return util.search_ancestors(startpath, function(path)
			return matches(path, root) and not matches(path, exclude)
		end)
	end
end

function B.match_filename_pattern(filename)
	local patterns = {
		"biome.json?",
		".eslint?"
	}
	for _, pattern in ipairs(patterns) do
		if filename:match(pattern) then
			return true
		end
	end
	return false
end

-- Mason export/restore utilities (portable: macOS/Linux/Windows)

-- Returns the absolute path to the list file we store in this config
function B.get_mason_list_file()
	return (vim.fn.stdpath("config") .. "/mason-packages.txt")
end

-- Export currently installed Mason packages to a text file (one per line)
function B.MasonExport()
	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		B.Err("mason-registry not available. Is mason.nvim installed?")
		return
	end

	local names = {}
	if type(registry.get_installed_package_names) == "function" then
		names = registry.get_installed_package_names()
	else
		-- Fallback for older mason: collect names from package objects
		local pkgs = registry.get_installed_packages()
		for _, pkg in ipairs(pkgs or {}) do
			if type(pkg.name) == "string" then
				table.insert(names, pkg.name)
			elseif type(pkg.name) == "function" then
				table.insert(names, pkg:name())
			end
		end
	end

	table.sort(names)
	local out = B.get_mason_list_file()
	local ok_write = pcall(vim.fn.writefile, names, out)
	if not ok_write then
		B.Err("Failed to write " .. out)
		return
	end
	B.Info("Mason packages exported to:\n  " .. out)
end

-- Restore Mason packages listed in the exported file (queues installs)
function B.MasonRestore()
	local file = B.get_mason_list_file()
	if vim.fn.filereadable(file) ~= 1 then
		B.Warn("No mason-packages.txt found at:\n  " .. file)
		return
	end

	local ok, registry = pcall(require, "mason-registry")
	if not ok then
		B.Err("mason-registry not available. Is mason.nvim installed?")
		return
	end

	local want = vim.fn.readfile(file)
	if not want or #want == 0 then
		B.Warn("mason-packages.txt is empty")
		return
	end

	local function do_restore()
		local queued, missing = 0, {}
		for _, name in ipairs(want) do
			local ok_pkg, pkg = pcall(registry.get_package, name)
			if not ok_pkg or not pkg then
				table.insert(missing, name)
			else
				if not pkg:is_installed() then
					pkg:install()
					queued = queued + 1
				end
			end
		end

		local msg = string.format("Queued %d installs from mason-packages.txt", queued)
		if #missing > 0 then
			msg = msg .. "\nMissing/unknown packages (check registry):\n  " .. table.concat(missing, ", ")
		end
		B.Info(msg)
	end

	-- Refresh registry first so restore works on fresh machines
	if type(registry.refresh) == "function" then
		registry.refresh(function()
			do_restore()
		end)
	else
		do_restore()
	end
end

-- User commands for manual control
pcall(function()
	vim.api.nvim_create_user_command(
		"MasonExport",
		function()
			require('becks.misc').MasonExport()
		end,
		{ desc = "Export installed Mason packages to mason-packages.txt" }
	)

	vim.api.nvim_create_user_command(
		"MasonRestore",
		function()
			require('becks.misc').MasonRestore()
		end,
		{ desc = "Restore Mason packages listed in mason-packages.txt" }
	)
end)

return B
