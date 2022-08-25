local M = {}

local util = require 'util'

local function get_config(name)
  local config = nil

  -- load config without modifying the path
  -- this is because cwd changes and must be aquired when this
  -- function is actually called
  local path = package.path
  package.path = package.path .. ';' .. vim.fn.getcwd() .. '/.nvim-config/?.lua'
  if util.is_module_available(name) then
    config = require(name)
  end
  package.path = path

  if config == nil then
    config = {}
  end
  return config
end

function M.get_lsp_config()
  return get_config 'lsp'
end

function M.get_jester_config()
  return get_config 'jest'
end

local function update_lsp_config()
  for _, client in ipairs(vim.lsp.get_active_clients()) do
    local new_settings = M.get_lsp_config()[client.name]
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
