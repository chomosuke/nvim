local M = {}

if require 'util'.is_module_available 'machine-specific' then
  M = require 'machine-specific'
end

if M.on_start == nil then
  M.on_start = function() end
else
  assert(type(M.on_start) == 'function', 'on_start have to be a function which will be ran at the end of init.lua.')
end

return M
