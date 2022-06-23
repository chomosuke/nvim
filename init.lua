-- for machine specific configuration
local function isModuleAvailable(name)
  if package.loaded[name] then
    return true
  else
    for _, searcher in ipairs(package.loaders) do
      local loader = searcher(name)
      if type(loader) == 'function' then
        package.preload[name] = loader
        return true
      end
    end
    return false
  end
end

if isModuleAvailable 'machine_specific' then
  require 'machine_specific'
end

require 'plugins'
require 'config'
require 'mapping'
