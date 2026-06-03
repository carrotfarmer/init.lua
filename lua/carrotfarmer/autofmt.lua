-- autoformat.lua
--
-- Use your language server to automatically format your code on save.
-- Adds additional commands as well to manage the behavior

local M = {}

function M.setup()
	local format_is_enabled = true

	vim.api.nvim_create_user_command("AutoFormatToggle", function()
		format_is_enabled = not format_is_enabled
		print("autoformat: " .. tostring(format_is_enabled))
	end, {})

	local augroups = {}

	local function get_augroup(client)
		if not augroups[client.id] then
			augroups[client.id] = vim.api.nvim_create_augroup("lsp-format-" .. client.name, { clear = true })
		end
		return augroups[client.id]
	end

	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			local bufnr = args.buf

			if not client.server_capabilities.documentFormattingProvider then
				return
			end

			vim.api.nvim_create_autocmd("BufWritePre", {
				group = get_augroup(client),
				buffer = bufnr,
				callback = function()
					if not format_is_enabled then
						return
					end

					vim.lsp.buf.format({
						async = false,
						filter = function(c)
							return c.id == client.id
						end,
					})
				end,
			})
		end,
	})
end

return M
