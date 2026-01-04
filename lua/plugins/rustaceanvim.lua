local function find_lldb()
	local guess = vim.fn.exepath("codelldb")
	if guess ~= "" then
		return guess
	end

	guess = vim.fn.exepath("lldb-dap")
	if guess ~= "" then
		return guess
	end

	return nil
end

return {
	{
		"mrcjkb/rustaceanvim",

		ft = "rust",

		init = function()
			local lldb_exe = find_lldb()

			if lldb_exe == nil then
				vim.notify("(rustaceanvim) Failed to find codelldb or lldb-dap")
			end

			local dap = lldb_exe and {
				type = "executable",
				command = lldb_exe,
				name = "lldb",
			} or nil

			vim.g.rustaceanvim = {
				dap = dap,
			}
		end
	},
}
