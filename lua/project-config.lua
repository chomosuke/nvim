local M = {}

---@param name string
---@param path string
---@return string|table|integer|nil
local function get_config(name, path)
  local dir = vim.fn.fnamemodify(path, ':p:h')
  while dir ~= '/' and vim.fn.isdirectory(dir .. '/.nvim-config') == 0 do
    dir = vim.fn.fnamemodify(dir, ':h')
  end

  local config_file = io.open(dir .. '/.nvim-config/' .. name .. '.json')
  if config_file == nil then
    return nil
  end

  local config = config_file:read '*all'
  config_file:close()

  config = vim.fn.json_decode(config)
  return config
end

---@param client_name string
---@param bufnr integer
---@return string|integer|table|nil
function M.get_lsp_config(client_name, bufnr)
  local config = get_config('lsp', vim.api.nvim_buf_get_name(bufnr))
  if config then
    config = config[client_name]
  end
  return config
end

---@param client_name string
---@param bufnr integer
---@return boolean
function M.get_formatter_enabled(client_name, bufnr)
  local config = get_config('no-format', vim.api.nvim_buf_get_name(bufnr))
  if config == nil then
    return true
  end
  assert(type(config) == 'table')
  for _, name in pairs(config) do
    if name == client_name then
      return false
    end
  end
  return true
end

return M
