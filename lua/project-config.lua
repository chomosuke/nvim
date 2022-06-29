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
  return get_config 'jester'
end

return M
