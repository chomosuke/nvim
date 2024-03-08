local util = require 'util'
local M = {}

local function expand_json_dot(obj)
  local new_obj = {}
  for k, v in pairs(obj) do
    local keys
    if type(k) == 'string' then
      keys = util.split(k, '%.')
    else
      keys = { k }
    end
    local o = new_obj
    local last_key = table.remove(keys, #keys)
    for _, key in pairs(keys) do
      o[key] = o[key] or {}
      o = o[key]
    end
    if type(v) == 'table' then
      v = expand_json_dot(v)
    end
    o[last_key] = v
  end
  return new_obj
end

---@param path string
---@return string|table|integer|nil
local function get_config(path)
  local dir = vim.fn.fnamemodify(path, ':p:h')
  local config_file = io.open(dir .. '/.nvim-config.json')
  while config_file == nil do
    local new_dir = vim.fn.fnamemodify(dir, ':h')
    if dir == new_dir then
      return nil
    end
    dir = new_dir
    config_file = io.open(dir .. '/.nvim-config.json')
  end

  local config = config_file:read '*all'
  config_file:close()

  config = expand_json_dot(vim.fn.json_decode(config))
  return config
end

---@param server_name string
---@param path string
---@return string|integer|table|nil
function M.get_lsp_config(server_name, path)
  local config = get_config(path)
  config = util.table_index(config, 'lsp', server_name, 'settings')
  if config == nil and _G.LspSetting ~= nil then
    -- Lsp settings can be set in .nvim.lua so that project specific settings can be applied
    -- Example:
    -- _G.LspSetting = {
    --   rust_analyzer = {
    --     ['rust-analyzer'] = {
    --       check = {
    --         command = 'clippy'
    --       }
    --     }
    --   }
    -- }
    config = _G.LspSetting[server_name]
  end
  return config
end

---@param client_name string
---@param bufnr integer
---@return boolean
function M.get_format_enabled(client_name, bufnr)
  local config = get_config(vim.api.nvim_buf_get_name(bufnr))
  if config == nil then
    return true
  end
  config = util.table_index(config, 'lsp', client_name, 'disable')
  if type(config) == 'table' then
    for _, disabled in pairs(config) do
      if disabled == 'format' then
        return false
      end
    end
  end
  return true
end

---@param params table
---@param source_name string
---@return boolean
function M.get_null_ls_source_enabled(params, source_name)
  local config = get_config(params.bufname)
  config = util.table_index(config, 'null-ls', 'disable')
  if config == nil then
    return true
  end
  for _, name in pairs(config) do
    if name == source_name then
      return false
    end
  end
  return true
end

vim.api.nvim_create_user_command('NvimConfig', function()
  -- generate .nvim-config.json
  vim.cmd(':e ' .. vim.fn.getcwd() .. '/.nvim-config.json')
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.defer_fn(function()
    local schema_path = vim.fn.fnamemodify(vim.fn.stdpath 'config', ':p') .. 'nvim-config-schema.json'
    schema_path = schema_path:gsub('\\', '/')
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {
      '{ "$schema": "' .. schema_path .. '" }',
    })
    ---@diagnostic disable-next-line: param-type-mismatch
  end, 10)
end, {})

return M
