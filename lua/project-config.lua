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

---@param server_name string
---@return string|integer|table|nil
function M.get_lsp_config(server_name)
  if _G.LspConfig ~= nil then
    -- Lsp settings can be set in .nvim.lua so that project specific settings can be applied
    -- Example:
    -- _G.LspConfig = {
    --   settings = {
    --     rust_analyzer = {
    --       ['rust-analyzer'] = {
    --         check = {
    --           command = 'clippy',
    --         },
    --       },
    --     },
    --   },
    --   clangd = {
    --     cmd = { "clangd", "--clang-tidy" },
    --   },
    -- }
    return _G.LspConfig[server_name]
  end
  return nil
end

---@param client_name string
---@return boolean
function M.get_format_enabled(client_name)
  local config = _G.LspConfig[client_name]
  if config == nil then
    return true
  end
  config = util.table_index(config, client_name, 'disable')
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
  local config = _G.NullLsDisable
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
    local schema_path = vim.fn.fnamemodify(vim.fn.stdpath 'config', ':p')
      .. 'nvim-config-schema.json'
    schema_path = schema_path:gsub('\\', '/')
    vim.api.nvim_buf_set_lines(0, 0, 0, false, {
      '{ "$schema": "' .. schema_path .. '" }',
    })
    ---@diagnostic disable-next-line: param-type-mismatch
  end, 10)
end, {})

return M
