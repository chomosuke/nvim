local M = {}

local util = require 'util'

---@param name string
---@return string|table|integer|nil
local function get_config(name)
  local config_file =
    io.open(vim.fn.getcwd() .. '/.nvim-config/' .. name .. '.json')
  if config_file == nil then
    return nil
  end

  local config = config_file:read('*all')
  config_file:close()

  config = vim.fn.json_decode(config)
  return config
end

---@param client_name string
---@return string|integer|table|nil
function M.get_lsp_config(client_name)
  local config = get_config 'lsp'
  if config then
    config = config[client_name]
  end
  return config
end

---@return string|integer|table|nil
function M.get_jester_config()
  return get_config 'jest'
end

---@param client_name string
---@return boolean
function M.get_formatter_enabled(client_name)
  local config = get_config 'no-format'
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

local function update_lsp_config()
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    local new_settings = M.get_lsp_config(client.name)
    if new_settings ~= nil then
      client.notify('workspace/didChangeConfiguration', {
        settings = new_settings,
      })
      client.config.settings = new_settings
    end
  end
end

function M.update_config()
  update_lsp_config()
end

-- update config when cwd changes
util.create_autocmds(
  'update_project_config',
  { { 'DirChanged', { callback = M.update_config } } }
)

return M
