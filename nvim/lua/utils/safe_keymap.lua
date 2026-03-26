local M = {}

local function normalize_modes(mode)
	if type(mode) == "table" then
		return mode
	end
	return { mode }
end

local function has_map(mode, lhs)
	for _, current_mode in ipairs(normalize_modes(mode)) do
		local map = vim.fn.maparg(lhs, current_mode, false, true)
		if type(map) == "table" and map.lhs ~= nil and map.lhs ~= "" then
			return true
		end
	end

	return false
end

function M.set(mode, lhs, rhs, opts)
	if has_map(mode, lhs) then
		return false
	end

	vim.keymap.set(mode, lhs, rhs, opts or {})
	return true
end

return M
